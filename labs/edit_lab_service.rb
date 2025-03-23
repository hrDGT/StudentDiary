# frozen_string_literal: true

require_relative '../commands/edit_command'

module Labs
  # Service class for editing a lab from the table
  class EditLabService
    def call
      Lab.new(id: process_id_input).exists? ? handle_form_validation : handle_missing_lab
    end

    private

    def process_id_input
      name = request_data_form_user(message: 'Введите название изменяемой лабы')
      discipline_name = request_data_form_user(message: 'Введите название дисциплины, к которой относится лаба')
      semester_name = request_data_form_user(message: 'Введите название семестра, к которой относится дисциплина')
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)
      discipline_id = Queries::DisciplinesQuery.id_by_name_and_semester(name: discipline_name, semester_id: semester_id)

      @id = Queries::LabsQuery.id_by_name_and_disicpline(name: name, discipline_id: discipline_id)
    end

    def process_new_data_input
      new_name = request_data_form_user(message: 'Введите новое название лабы')
      new_deadline = request_data_form_user(message: 'Введите новый дедлайн лабы (yyyy-mm-dd)')
      new_grade = request_data_form_user(message: 'Введите новую отметку за лабу (оставьте пустым, если неизвестна)')
      new_discipline_name = request_data_form_user(message: 'Введите новую дисциплину, к которой относится лаба')
      new_semester_name = request_data_form_user(message: 'Введите новый семестр, к которому относится дисциплина')
      new_semester_id = Queries::SemestersQuery.id_by_name(name: new_semester_name)
      new_discipline_id = Queries::DisciplinesQuery.id_by_name_and_semester(name: new_discipline_name,
                                                                            semester_id: new_semester_id)

      @form = LabsForm.new(name: new_name, deadline: new_deadline, grade: new_grade, discipline_id: new_discipline_id)
    end

    def request_data_form_user(message:)
      puts message

      gets.chomp
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_lab
        puts 'Лаба успешно изменена!'
      else
        puts 'Ошибки ввода:'
        puts @form.errors
      end

      Utilities::LinesCleaner.instance.lines_to_clear += 17 + @form.errors.size
    end

    def handle_missing_lab
      puts 'Лабы с указанным названием не существует'

      Utilities::LinesCleaner.instance.lines_to_clear += 7
    end

    def generate_status
      current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)

      current_date < @form.deadline ? 'not completed' : 'completed'
    end

    def convert_grade
      @form.grade == '' ? nil : @form.grade
    end

    def edit_lab
      Commands::EditCommand.new(
        table: 'labs',
        id: @id,
        updates: { name: @form.name, deadline: @form.deadline, status: generate_status, grade: convert_grade,
                   discipline_id: @form.discipline_id }
      ).execute
    end
  end
end

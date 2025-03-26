# frozen_string_literal: true

require_relative '../commands/add_command'

module Labs
  # Service class for adding a new lab to the table
  class AddNewLabService
    def call
      process_user_input
      if @form.valid?(is_adding: true)
        add_lab

        Utilities::LinesCleaner.instance.lines_to_clear += 10
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 11 + @form.errors.size
      end
    end

    private

    def process_user_input
      name = request_data_form_user(message: 'Введите название лабы')
      deadline = request_data_form_user(message: 'Введите дедлайн лабы (yyyy-mm-dd)')
      grade = request_data_form_user(message: 'Введите отметку за лабу (оставьте пустым, если неизвестна)')
      discipline_name = request_data_form_user(message: 'Введите название дисциплины, к которой относится лаба')
      semester_name = request_data_form_user(message: 'Введите название семестра, к которому относится дисциплина')
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)
      discipline_id = Queries::DisciplinesQuery.id_by_name_and_semester(name: discipline_name, semester_id: semester_id)

      @form = LabsForm.new(name: name, deadline: deadline, grade: grade, discipline_id: discipline_id)
    end

    def request_data_form_user(message:)
      puts message

      gets.chomp
    end

    def generate_status
      current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)

      current_date < @form.deadline ? 'not completed' : 'completed'
    end

    def convert_grade
      @form.grade == '' ? nil : @form.grade
    end

    def add_lab
      Commands::AddCommand.new(
        table: 'labs',
        name: @form.name,
        deadline: @form.deadline,
        status: generate_status,
        grade: convert_grade,
        discipline_id: @form.discipline_id
      ).execute
    end
  end
end

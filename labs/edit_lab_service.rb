# frozen_string_literal: true

require_relative '../commands/edit_command'

module Labs
  # Service class for editing a lab from the table
  class EditLabService
    def call
      lab_exists?(id: process_id_input) ? handle_form_validation : handle_missing_lab
    end

    private

    def process_id_input
      puts 'Введите id изменяемой лабы'
      @id = gets.chomp
    end

    def process_new_data_input
      new_name = request_data_form_user(message: 'Введите новое название лабы')
      new_deadline = request_data_form_user(message: 'Введите новый дедлайн лабы')
      new_status = request_data_form_user(message: 'Введите новый статус лабы (completed/not completed)')
      new_grade = request_data_form_user(message: 'Введите новую отметку за лабу (оставьте пустым, если неизвестна)')
      new_discipline_id = request_data_form_user(message: 'Введите новый id дисциплины, к которой относится лаба')

      @form = LabsForm.new(name: new_name, deadline: new_deadline, status: new_status, grade: new_grade,
                           discipline_id: new_discipline_id)
    end

    def request_data_form_user(message:)
      puts message

      gets.chomp
    end

    def lab_exists?(id:)
      Queries::LabsQuery.new.exists?(id: id)
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_lab

        Utilities::LinesCleaner.instance.lines_to_clear += 12
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 13 + @form.errors.size
      end
    end

    def handle_missing_lab
      puts 'Дисциплины с указанным названием не существует'

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    def convert_grade
      @form.grade == '' ? nil : @form.grade
    end

    def edit_lab
      Commands::EditCommand.new(
        table: 'labs',
        id: @id,
        updates: { name: @form.name, deadline: @form.deadline, status: @form.status, grade: convert_grade,
                   discipline_id: @form.discipline_id }
      ).execute
    end
  end
end

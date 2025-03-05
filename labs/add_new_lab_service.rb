# frozen_string_literal: true

require_relative '../commands/add_command'

module Labs
  # Service class for adding a new lab to the table
  class AddNewLabService
    def call
      process_user_input
      if @form.valid?
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
      status = request_data_form_user(message: 'Введите статус лабы (completed/not completed)')
      grade = request_data_form_user(message: 'Введите отметку за лабу (оставьте пустым, если неизвестна)')
      discipline_id = request_data_form_user(message: 'Введите id дисциплины, к которой относится лаба')

      @form = LabsForm.new(name: name, deadline: deadline, status: status, grade: grade,
                           discipline_id: discipline_id)
    end

    def request_data_form_user(message:)
      puts message

      gets.chomp
    end

    def convert_grade
      @form.grade == '' ? nil : @form.grade
    end

    def add_lab
      Commands::AddCommand.new(
        table: 'labs',
        name: @form.name,
        deadline: @form.deadline,
        status: @form.status,
        grade: convert_grade,
        discipline_id: @form.discipline_id
      ).execute
    end
  end
end

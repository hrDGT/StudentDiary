# frozen_string_literal: true

require_relative '../commands/edit_command'
require_relative 'execution'

module Semesters
  # Service class for editing a semester from the table
  class EditSemesterService
    def call
      process_old_name_input

      semester_exists? ? handle_form_validation : handle_missing_semester
    end

    private

    def process_old_name_input
      puts 'Введите id изменяемого семестра'
      @id = gets.chomp
    end

    def process_new_data_input
      puts 'Введите новое название семестра:'
      new_name = gets.chomp
      puts 'Введите новую дату начала семестра (yyyy-mm-dd)'
      start_date = gets.chomp
      puts 'Введите новую дату окончания семестра (yyyy-mm-dd)'
      end_date = gets.chomp

      @form = SemestersForm.new(name: new_name, start_date: start_date, end_date: end_date)
    end

    def semester_exists?
      Database::Database.instance.execute_query(query: "SELECT 1 FROM semesters WHERE id = $1", values: [@id]).any?
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_semester

        Execution.instance_variable_set(:@lines_to_clear, 8)
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Execution.instance_variable_set(:@lines_to_clear, 9 + @form.errors.size)
      end
    end

    def handle_missing_semester
      puts 'Семестра с указанным названием не существует'

      Execution.instance_variable_set(:@lines_to_clear, 3)
    end

    def edit_semester
      command = Commands::EditCommand.new(table: 'semesters', id: @id, updates: {
                                            name: @form.name,
                                            start_date: @form.start_date,
                                            end_date: @form.end_date
                                          })

      command.execute
    end
  end
end

# frozen_string_literal: true

require_relative '../commands/delete_command'

module Semesters
  # Service class for deleting a semester from the table
  class DeleteSemesterService
    def call
      process_user_input
      Semester.new(id: @id).exists? ? delete_semester : handle_existence_error

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    private

    def process_user_input
      puts 'Введите id удаляемого семестра'
      @id = gets.chomp
    end

    def delete_semester
      Commands::DeleteCommand.new(table: 'semesters', id: @id).execute
      puts 'Семестр успешно удален'
    end

    def handle_existence_error
      puts 'Указанный семестр не найден'
    end
  end
end

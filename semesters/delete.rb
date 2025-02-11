# frozen_string_literal: true

require_relative '../commands/delete_command'
require_relative '../queries/if_semester_exists'
require_relative 'execution'

module Semesters
  # Service class for deleting a semester from the table
  class DeleteSemesterService
    def call
      process_user_input
      Queries::IfSemesterExists.new.execute(id: @id) ? delete_semester : handle_existence_error

      Execution.instance_variable_set(:@lines_to_clear, 3)
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

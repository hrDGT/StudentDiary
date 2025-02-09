# frozen_string_literal: true

require_relative '../commands/delete_command'
require_relative 'execution'

module Semesters
  # Service class for deleting a semester from the table
  class DeleteSemesterService
    def call
      process_user_input
      delete_semester

      Execution.instance_variable_set(:@lines_to_clear, 2)
    end

    private

    def process_user_input
      puts 'Введите id удаляемого семестра'
      @id = gets.chomp
    end

    def delete_semester
      command = Commands::DeleteCommand.new(table: 'semesters', id: @id)
      command.execute
    end
  end
end

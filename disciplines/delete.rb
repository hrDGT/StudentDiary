# frozen_string_literal: true

require_relative '../commands/delete_command'

module Disciplines
  # Service class for deleting a disciplines from the table
  class DeleteDisciplineService
    def call
      process_user_input
      Queries::DisciplinesQuery.new.exists?(id: @id) ? delete_discipline : handle_existence_error

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    private

    def process_user_input
      puts 'Введите id удаляемой дисциплины'
      @id = gets.chomp
    end

    def delete_discipline
      Commands::DeleteCommand.new(table: 'disciplines', id: @id).execute
      puts 'Семестр успешно удален'
    end

    def handle_existence_error
      puts 'Указанная дисциплина не найдена'
    end
  end
end

# frozen_string_literal: true

require_relative '../commands/delete_command'

module Labs
  # Service class for deleting a labs from the table
  class DeleteLabService
    def call
      process_user_input
      Lab.new(id: @id).exists? ? delete_lab : handle_existence_error

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    private

    def process_user_input
      puts 'Введите id удаляемой лабы'
      @id = gets.chomp
    end

    def delete_lab
      Commands::DeleteCommand.new(table: 'labs', id: @id).execute
      puts 'Лаба успешно удалена'
    end

    def handle_existence_error
      puts 'Указанная лаба не найдена'
    end
  end
end

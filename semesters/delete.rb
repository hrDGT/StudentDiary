# frozen_string_literal: true

require_relative '../commands/delete_command'
require_relative 'execution'

module Semesters
  # Specified delete command for semesters table
  module Delete
    def self.delete
      puts 'Введите название удаляемого семестра'
      name = gets.chomp

      command = Commands::DeleteCommand.new(table: 'semesters', name: name)
      command.execute

      Semesters::Execution.instance_variable_set(:@lines_to_clear, 2)
    end
  end
end

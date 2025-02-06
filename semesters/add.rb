# frozen_string_literal: true

require_relative '../commands/add_command'
require_relative 'execution'

module Semesters
  # Specified add command for semesters table
  module Add
    def self.add
      name = input_name
      start_date = input_start_date
      end_date = input_end_date

      command = Commands::AddCommand.new(table: 'semesters', name: name, start_date: start_date, end_date: end_date)
      command.execute

      Semesters::Execution.instance_variable_set(:@lines_to_clear, 6)
    end

    def self.input_name
      puts 'Введите название семестра'
      gets.chomp
    end

    def self.input_start_date
      puts 'Введите дату начала семестра (yyyy-mm-dd)'
      date = gets.chomp
      until valid_date_format?(date)
        puts 'Неправильный формат даты. Попробуйте еще раз (yyyy-mm-dd):'
        date = gets.chomp
      end
      date
    end

    def self.input_end_date
      puts 'Введите дату окончания семестра (yyyy-mm-dd)'
      date = gets.chomp
      until valid_date_format?(date)
        puts 'Неправильный формат даты. Попробуйте еще раз (yyyy-mm-dd):'
        date = gets.chomp
      end
      date
    end

    def self.valid_date_format?(date)
      date.match(/\d{4}-\d{2}-\d{2}/)
    end
  end
end

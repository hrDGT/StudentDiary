# frozen_string_literal: true

require_relative '../commands/edit_command'
require_relative 'execution'

module Semesters
  # Specified edit command for semesters table
  module Edit
    def self.edit
      old_name = input_old_name
      new_name = input_new_name
      new_start_date = input_new_start_date
      new_end_date = input_new_end_date

      updates = create_updates_hash(new_name, new_start_date, new_end_date)

      update_semester_in_database(updates, old_name)

      Semesters::Execution.instance_variable_set(:@lines_to_clear, 8)
    end

    def self.input_old_name
      puts 'Введите название изменяемого семестра'
      gets.chomp
    end

    def self.input_new_name
      puts 'Введите новое название семестра'
      gets.chomp
    end

    def self.input_new_start_date
      puts 'Введите новую дату начала семестра (yyyy-mm-dd)'
      date = gets.chomp
      until valid_date_format?(date)
        puts 'Неправильный формат даты. Попробуйте еще раз (yyyy-mm-dd):'
        date = gets.chomp
      end
      date
    end

    def self.input_new_end_date
      puts 'Введите новую дату окончания семестра (yyyy-mm-dd)'
      date = gets.chomp
      until valid_date_format?(date)
        puts 'Неправильный формат даты. Попробуйте еще раз (yyyy-mm-dd):'
        date = gets.chomp
      end
      date
    end

    def self.create_updates_hash(new_name, new_start_date, new_end_date)
      {
        'name' => new_name,
        'start_date' => new_start_date,
        'end_date' => new_end_date
      }
    end

    def self.update_semester_in_database(updates, old_name)
      command = Commands::EditCommand.new(table: 'semesters', updates: updates, name: old_name)
      command.execute
    end

    def self.valid_date_format?(date)
      date.match(/\d{4}-\d{2}-\d{2}/)
    end
  end
end

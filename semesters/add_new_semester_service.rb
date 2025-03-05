# frozen_string_literal: true

require_relative '../commands/add_command'

module Semesters
  # Service class for adding a new semester to the table
  class AddNewSemesterService
    def call
      process_user_input
      if @form.valid?
        add_semester

        Utilities::LinesCleaner.instance.lines_to_clear += 6
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 7 + @form.errors.size
      end
    end

    private

    def process_user_input
      puts 'Введите название семестра'
      name = gets.chomp
      puts 'Введите дату начала семестра (yyyy-mm-dd)'
      start_date = gets.chomp
      puts 'Введите дату окончания семестра (yyyy-mm-dd)'
      end_date = gets.chomp

      @form = SemestersForm.new(name: name, start_date: start_date, end_date: end_date)
    end

    def add_semester
      Commands::AddCommand.new(
        table: 'semesters',
        name: @form.name,
        start_date: @form.start_date,
        end_date: @form.end_date
      ).execute
    end
  end
end

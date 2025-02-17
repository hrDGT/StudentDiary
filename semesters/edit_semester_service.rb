# frozen_string_literal: true

require_relative '../commands/edit_command'

module Semesters
  # Service class for editing a semester from the table
  class EditSemesterService
    def call
      semester_exists?(id: process_id_input) ? handle_form_validation : handle_missing_semester
    end

    private

    def process_id_input
      puts 'Введите id изменяемого семестра'
      @id = gets.chomp
    end

    def process_new_data_input
      puts 'Введите новое название семестра'
      new_name = gets.chomp
      puts 'Введите новую дату начала семестра (yyyy-mm-dd)'
      start_date = gets.chomp
      puts 'Введите новую дату окончания семестра (yyyy-mm-dd)'
      end_date = gets.chomp

      @form = SemestersForm.new(name: new_name, start_date: start_date, end_date: end_date)
    end

    def semester_exists?(id:)
      Queries::SemestersQuery.new.exists?(id: id)
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_semester

        Utilities::LinesCleaner.instance.lines_to_clear += 8
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 9 + @form.errors.size
      end
    end

    def handle_missing_semester
      puts 'Семестра с указанным названием не существует'

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    def edit_semester
      Commands::EditCommand.new(
        table: 'semesters',
        id: @id,
        updates: { name: @form.name, start_date: @form.start_date, end_date: @form.end_date }
      ).execute
    end
  end
end

# frozen_string_literal: true

require_relative '../commands/edit_command'

module Disciplines
  # Service class for editing a discipline from the table
  class EditDisciplineService
    def call
      discipline_exists?(id: process_id_input) ? handle_form_validation : handle_missing_semester
    end

    private

    def process_id_input
      puts 'Введите id изменяемой дисциплины'
      @id = gets.chomp
    end

    def process_new_data_input
      puts 'Введите новое название дисциплины'
      new_name = gets.chomp
      puts 'Введите новый id семестра, к которому относится дисциплина'
      new_semester_id = gets.chomp

      @form = DisciplinesForm.new(name: new_name, semester_id: new_semester_id)
    end

    def discipline_exists?(id:)
      Queries::DisciplinesQuery.new.exists?(id: id)
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_discipline

        Utilities::LinesCleaner.instance.lines_to_clear += 6
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 7 + @form.errors.size
      end
    end

    def handle_missing_semester
      puts 'Дисциплины с указанным названием не существует'

      Utilities::LinesCleaner.instance.lines_to_clear += 3
    end

    def edit_discipline
      Commands::EditCommand.new(
        table: 'disciplines',
        id: @id,
        updates: { name: @form.name, semester_id: @form.semester_id }
      ).execute
    end
  end
end

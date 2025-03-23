# frozen_string_literal: true

require_relative '../commands/edit_command'

module Disciplines
  # Service class for editing a discipline from the table
  class EditDisciplineService
    def call
      Discipline.new(id: process_id_input).exists? ? handle_form_validation : handle_missing_discipline
    end

    private

    def process_id_input
      puts 'Введите название изменяемой дисциплины'
      name = gets.chomp
      puts 'Введите название семестра, к которому относится изменяемая дисциплина'
      semester_name = gets.chomp
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)

      @id = Queries::DisciplinesQuery.id_by_name_and_semester(name: name, semester_id: semester_id)
    end

    def process_new_data_input
      puts 'Введите новое название дисциплины'
      new_name = gets.chomp
      puts 'Введите название нового семестра, к которому относится дисциплина'
      new_semester_name = gets.chomp
      new_semester_id = Queries::SemestersQuery.id_by_name(name: new_semester_name)

      @form = DisciplinesForm.new(name: new_name, semester_id: new_semester_id)
    end

    def handle_form_validation
      process_new_data_input
      if @form.valid?
        edit_discipline

        Utilities::LinesCleaner.instance.lines_to_clear += 8
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 9 + @form.errors.size
      end
    end

    def handle_missing_discipline
      puts 'Дисциплины с указанным названием не существует'

      Utilities::LinesCleaner.instance.lines_to_clear += 5
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

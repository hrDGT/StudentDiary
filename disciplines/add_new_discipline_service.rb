# frozen_string_literal: true

require_relative '../commands/add_command'

module Disciplines
  # Service class for adding a new discipline to the table
  class AddNewDisciplineService
    def call
      process_user_input
      if @form.valid?(is_adding: true)
        add_discipline

        Utilities::LinesCleaner.instance.lines_to_clear += 4
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 5 + @form.errors.size
      end
    end

    private

    def process_user_input
      puts 'Введите название дисциплины'
      name = gets.chomp
      puts 'Введите название семестра, к которому относится дисциплина'
      semester_name = gets.chomp
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)

      @form = DisciplinesForm.new(name: name, semester_id: semester_id)
    end

    def add_discipline
      Commands::AddCommand.new(
        table: 'disciplines',
        name: @form.name,
        semester_id: @form.semester_id
      ).execute
    end
  end
end

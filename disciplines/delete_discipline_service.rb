# frozen_string_literal: true

require_relative '../commands/delete_command'

module Disciplines
  # Service class for deleting a disciplines from the table
  class DeleteDisciplineService
    def call
      process_user_input
      return handle_existence_error(type: :semester) unless semester_exists?

      Discipline.new(id: @id).exists? ? delete_discipline : handle_existence_error(type: :discipline)

      Utilities::LinesCleaner.instance.lines_to_clear += 5
    end

    private

    def process_user_input
      puts 'Введите название удаляемой дисциплины'
      discipline_name = gets.chomp
      puts 'Введите название семестра с удаляемой дисциплиной'
      semester_name = gets.chomp
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)

      @id = Queries::DisciplinesQuery.id_by_name_and_semester(name: discipline_name, semester_id: semester_id)
      @additional_info = { semester_id: semester_id }
    end

    def semester_exists?
      Semester.new(id: @additional_info[:semester_id]).exists?
    end

    def delete_discipline
      Commands::DeleteCommand.new(table: 'disciplines', id: @id, additional_info: @additional_info).execute

      puts 'Дисциплина успешно удалена'
    end

    def handle_existence_error(type:)
      case type
      when :discipline
        puts 'Указанная дисциплина не найдена'
      when :semester
        puts 'Указанный семестр не найден'

        Utilities::LinesCleaner.instance.lines_to_clear += 5
      else
        raise 'Wrong status!'
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../commands/delete_command'

module Labs
  # Service class for deleting a labs from the table
  class DeleteLabService
    def call
      process_user_input
      Lab.new(id: @id).exists? ? delete_lab : handle_existence_error

      Utilities::LinesCleaner.instance.lines_to_clear += 7
    end

    private

    def process_user_input
      puts 'Введите название удаляемой лабы'
      name = gets.chomp
      puts 'Введите название дисциплины, к которой относится лаба'
      discipline_name = gets.chomp
      puts 'Введите название семестра, к которой относится дисциплина'
      semester_name = gets.chomp
      semester_id = Queries::SemestersQuery.id_by_name(name: semester_name)
      discipline_id = Queries::DisciplinesQuery.id_by_name_and_semester(name: discipline_name, semester_id: semester_id)

      @id = Queries::LabsQuery.id_by_name_and_disicpline(name: name, discipline_id: discipline_id)
      @additional_info = { discipline_id: discipline_id }
    end

    def delete_lab
      Commands::DeleteCommand.new(table: 'labs', id: @id, additional_info: @additional_info).execute

      puts 'Лаба успешно удалена'
    end

    def handle_existence_error
      puts 'Указанная лаба не найдена'
    end
  end
end

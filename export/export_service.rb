# frozen_string_literal: true

require 'csv'

module Export
  # Service class for exporting tables
  class ExportService
    def call
      process_user_input

      if @form.valid?
        @form.dir = File.join(@form.dir, 'export.csv')
        export

        Utilities::LinesCleaner.instance.lines_to_clear += 4
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 5 + @form.errors.size
      end
    end

    private

    def process_user_input
      puts 'Введите путь в формате c:/path/to/file (оставьте пустым, чтобы сохранить в studentdiary):'
      dir = gets.chomp
      dir = '../studentdiary' if dir == ''
      puts 'Введите таблицу, которую хотите сохранить (semesters, disciplines, labs)'
      table = gets.chomp

      @form = ExportForm.new(dir: dir, table: table)
    end

    def export
      data = Database::Database.instance.execute_query(query: "SELECT * FROM #{@form.table}")

      CSV.open(@form.dir, 'w') do |file|
        file << data.first.keys
        data.each { |line| file << line.values }
      end
    end
  end
end

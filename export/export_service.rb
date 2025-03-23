# frozen_string_literal: true

require 'csv'

module Export
  # Service class for exporting tables
  class ExportService
    def call
      process_user_input
      @form.valid? ? export : handle_input_errors

      Utilities::LinesCleaner.instance.lines_to_clear += 5 + @form.errors.size
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
      dir = File.join(@form.dir, "#{@form.table}.csv")
      data = Database::Database.instance.execute_query(query: "SELECT * FROM #{@form.table}")
      return handle_emptiness_error if data.first.nil?

      save_to_csv(dir: dir, data: data)

      puts "Данные успешно экспортированы в файл #{@form.table}.csv!"
    end

    def save_to_csv(dir:, data:)
      CSV.open(dir, 'w') do |file|
        file << data.first.keys
        data.each { |line| file << line.values }
      end
    end

    def handle_input_errors
      puts 'Ошибки ввода:'

      puts @form.errors
    end

    def handle_emptiness_error
      puts 'Таблица пуста!'
    end
  end
end

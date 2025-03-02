# frozen_string_literal: true

module Export
  # Validate export related date
  class ExportForm
    attr_accessor :dir, :errors, :table

    def initialize(dir:, table:)
      @dir = dir
      @table = table
      @errors = []
    end

    def valid?
      validate_directory
      validate_table

      errors.empty?
    end

    private

    TABLES_NAMES = %w[semesters disciplines labs].freeze

    def validate_directory
      errors << 'Неправильный формат директории' if !@dir.match?(%r{^[a-zA-Z]:/}) && @dir != '../studentdiary'
    end

    def validate_table
      errors << 'Неправильная таблица' unless TABLES_NAMES.include?(@table)
    end
  end
end

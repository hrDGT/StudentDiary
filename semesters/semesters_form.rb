# frozen_string_literal: true

module Semesters
  # Validate semester related date
  class SemestersForm
    attr_accessor :name, :start_date, :end_date, :errors

    def initialize(name:, start_date:, end_date:)
      @name = name
      @start_date = start_date
      @end_date = end_date
      @errors = []
    end

    def valid?
      validate_name
      validate_start_date
      validate_end_date
      validate_dates_order

      errors.empty?
    end

    private

    def validate_name
      errors << 'Пустое название семестра' if name.empty?
    end

    def validate_start_date
      errors << 'Неправильный формат даты начала семестра' unless valid_date_format?(start_date)
    end

    def validate_end_date
      errors << 'Неправильный формат даты окончания семестра' unless valid_date_format?(end_date)
    end

    def validate_dates_order
      errors << 'Дата окончания не может быть раньше даты начала или равна ей' if start_date >= end_date
    end

    def valid_date_format?(date)
      date.match(/\d{4}-\d{2}-\d{2}/)
    end
  end
end

# frozen_string_literal: true

module Labs
  # Validate lab related data
  class LabsForm
    attr_accessor :name, :deadline, :grade, :discipline_id, :errors

    def initialize(name:, deadline:, grade:, discipline_id:)
      @name = name
      @deadline = deadline
      @grade = grade
      @discipline_id = discipline_id
      @errors = []
    end

    def valid?(is_adding: false)
      validate_name
      if is_adding
        validate_name_uniqueness unless validate_discipline_id
      else
        validate_discipline_id
      end
      validate_deadline
      validate_grade

      errors.empty?
    end

    private

    STATUSES = ['completed', 'not completed'].freeze

    def validate_name
      errors << 'Пустое название лабы' if @name.empty?
    end

    def validate_discipline_id
      errors << 'Указанной дисциплины не существует' unless Discipline.new(id: @discipline_id).exists?
    end

    def validate_name_uniqueness
      return unless Queries::LabsQuery.id_by_name_and_disicpline(name: @name, discipline_id: @discipline_id)

      errors << 'Лаба с указанным названием уже сущетвует в этой дисциплине'
    end

    def validate_deadline
      errors << 'Неправильный формат дедлайна' unless valid_date_format?(@deadline)
    end

    def validate_grade
      return if (@grade.match?(/^\d+$/) && !@grade.to_i.negative? && @grade.to_i <= 10) || @grade.empty?

      errors << 'Неправильная отметка'
    end

    def valid_date_format?(date)
      date.match?(/\d{4}-\d{2}-\d{2}/)
      Date.parse(date)
    rescue Date::Error
      false
    end
  end
end

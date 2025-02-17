# frozen_string_literal: true

module Labs
  # Validate lab related date
  class LabsForm
    attr_accessor :name, :deadline, :status, :grade, :discipline_id, :errors

    def initialize(name:, deadline:, status:, grade:, discipline_id:)
      @name = name
      @deadline = deadline
      @status = status
      @grade = grade
      @discipline_id = discipline_id
      @errors = []
    end

    def valid?
      validate_name
      validate_deadline
      validate_status
      validate_grade
      validate_discipline_id

      errors.empty?
    end

    private

    STATUSES = ['completed', 'not completed'].freeze

    def validate_name
      errors << 'Пустое название лабы' if name.empty?
    end

    def validate_deadline
      errors << 'Неправильный формат дедлайна' unless valid_date_format?(@deadline)
    end

    def validate_status
      errors << 'Неправильный cтатус' if @status != 'completed' && @status != 'not completed'
    end

    def validate_grade
      errors << 'Неправильная отметка' if !@grade.match?(/^-?\d+$/) && @grade != ''
    end

    def validate_discipline_id
      @discipline_id == '' ? (errors << 'Пустой id дисциплины') : validate_discipline_existence
    end

    def validate_discipline_existence
      errors << 'Указанной дисциплины не существует' unless Queries::DisciplinesQuery.new.exists?(id: @discipline_id)
    end

    def valid_date_format?(date)
      date.match?(/\d{4}-\d{2}-\d{2}/)
    end
  end
end

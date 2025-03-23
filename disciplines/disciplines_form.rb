# frozen_string_literal: true

module Disciplines
  # Validate semester related data
  class DisciplinesForm
    attr_accessor :name, :semester_id, :errors

    def initialize(name:, semester_id:)
      @name = name
      @semester_id = semester_id
      @errors = []
    end

    def valid?(is_adding: false)
      validate_name
      if is_adding
        validate_name_uniqueness unless validate_semester_id
      else
        validate_semester_id
      end

      errors.empty?
    end

    private

    def validate_name
      errors << 'Пустое название дисциплины' if @name.empty?
    end

    def validate_semester_id
      errors << 'Указанного семестра не существует' unless Semester.new(id: @semester_id).exists?
    end

    def validate_name_uniqueness
      return unless Queries::DisciplinesQuery.name_exists_in_semester?(name: @name, semester_id: @semester_id)

      errors << 'Дисциплина с указанным названием уже сущетвует в этом семестре'
    end
  end
end

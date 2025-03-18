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

    def valid?
      validate_name
      validate_semester_id
      validate_name_uniqueness

      errors.empty?
    end

    private

    def validate_name
      errors << 'Пустое название дисциплины' if @name.empty?
    end

    def validate_name_uniqueness
      return unless Queries::DisciplinesQuery.name_exists_in_semester?(name: @name, semester_id: @semester_id)

      errors << 'Дисциплина с указанным названием уже сущетвует в этом семестре'
    end

    def validate_semester_id
      errors << 'Указанного семестра не существует' unless Semester.new(id: @semester_id).exists?
    end
  end
end

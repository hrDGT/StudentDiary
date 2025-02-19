# frozen_string_literal: true

module Disciplines
  # Validate semester related date
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

      errors.empty?
    end

    private

    def validate_name
      errors << 'Пустое название дисциплины' if @name.empty?
    end

    def validate_semester_id
      @semester_id == '' ? errors << 'Пустой id семестра' : validate_semester_existence
    end

    def validate_semester_existence
      errors << 'Указанного семестра не существует' unless Queries::SemestersQuery.new.exists?(id: @semester_id)
    end
  end
end

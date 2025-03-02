# frozen_string_literal: true

module Analytics
  # Validate analytics related data
  class AnalyticsForm
    attr_accessor :id, :errors

    def initialize(id:)
      @id = id
      @errors = []
    end

    def valid?
      validate_id
      validate_existence if errors.empty?

      errors.empty?
    end

    private

    def validate_id
      errors << 'Пустой id семестра' if @id == ''
    end

    def validate_existence
      errors << 'Указанного семестра не существует' unless Semester.new(id: id).exists?
    end
  end
end

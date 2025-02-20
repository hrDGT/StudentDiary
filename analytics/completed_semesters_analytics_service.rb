# frozen_string_literal: true

module Analytics
  # Service class to get analytics for completed semesters
  class CompletedSemestersAnalyticsService
    include AnalyticsProcess
    include AnalyticsCalculations
    include AnalyticsOperations

    def initialize(type:)
      @type = type
    end

    def call
      process_analytics(type: ANALYTICS_TYPES[@type])
    end

    private

    ANALYTICS_TYPES = {
      completed_grades: :print_discipline_average_grades_analytics,
      completed_full: :print_semester_analytics
    }.freeze

    def process_analytics(type:)
      Queries::SemestersQuery.new.all_ids(status: :completed).each { |id| send(type, id: id) }
    end
  end
end

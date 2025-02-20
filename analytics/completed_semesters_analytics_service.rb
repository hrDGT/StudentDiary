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
      send(ANALYTICS_TYPES[@type])
    end

    private

    ANALYTICS_TYPES = {
      completed_grades: :process_average_grades_analytics,
      completed_full: :process_full_analytics
    }.freeze

    def process_average_grades_analytics
      Queries::SemestersQuery.new.all_ids.flatten.each do |id|
        print_discipline_average_grades_analytics(id: id) if Queries::SemestersQuery.new.status(id: id) == 'Completed'
      end
    end

    def process_full_analytics
      Queries::SemestersQuery.new.all_ids.flatten.each do |id|
        print_semester_analytics(id: id) if Queries::SemestersQuery.new.status(id: id) == 'Completed'
      end
    end
  end
end

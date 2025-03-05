# frozen_string_literal: true

module Analytics
  # Service class to get analytics for active semesters
  class ActiveSemestersAnalyticsService
    include AnalyticsPrint
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
      active_grades: :print_discipline_average_grades_analytics,
      active_uncompleted: :print_uncompleted_lab_analytics,
      active_full: :print_semester_analytics
    }.freeze

    def process_analytics(type:)
      Queries::SemestersQuery.new.all_ids(status: :active).each { |id| send(type, id: id) }
    end
  end
end

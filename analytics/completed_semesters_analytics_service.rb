# frozen_string_literal: true

module Analytics
  # Service class to get analytics for completed semesters
  class CompletedSemestersAnalyticsService
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
      completed_grades: :print_discipline_average_grades_analytics,
      completed_full: :print_semester_analytics
    }.freeze

    def process_analytics(type:)
      active_semester_ids = Queries::SemestersQuery.new.all_ids(status: :completed)
      return active_semester_ids.each { |id| send(type, id: id) } if active_semester_ids.any?

      puts 'Не найдено ни одного активного семестра'
      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end
  end
end

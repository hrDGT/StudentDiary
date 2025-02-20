# frozen_string_literal: true

module Analytics
  # Service class to get analytics for active semesters
  class ActiveSemestersAnalyticsService
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
      active_grades: :process_average_grades_analytics,
      active_uncompleted: :process_uncompleted_labs_analytics,
      active_full: :process_full_analytics
    }.freeze

    def process_average_grades_analytics
      Queries::SemestersQuery.new.all_ids.flatten.each do |id|
        print_discipline_average_grades_analytics(id: id) if Queries::SemestersQuery.new.status(id: id) == 'Active'
      end
    end

    def process_uncompleted_labs_analytics
      Queries::SemestersQuery.new.all_ids.flatten.each do |id|
        print_uncompleted_lab_analytics(id: id) if Queries::SemestersQuery.new.status(id: id) == 'Active'
      end
    end

    def process_full_analytics
      Queries::SemestersQuery.new.all_ids.flatten.each do |id|
        print_semester_analytics(id: id) if Queries::SemestersQuery.new.status(id: id) == 'Active'
      end
    end
  end
end

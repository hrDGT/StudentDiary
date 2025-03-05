# frozen_string_literal: true

require_relative '../queries/semesters_query'
require_relative '../queries/disciplines_query'
require_relative '../queries/labs_query'
require_relative '../semester'
require_relative '../lab'
require_relative '../discipline'
require_relative 'analytics_print'
require_relative 'analytics_calculations'
require_relative 'analytics_operations'
require_relative 'analytics_form'
require_relative 'specific_semester_analytics_service'
require_relative 'active_semesters_analytics_service'
require_relative 'completed_semesters_analytics_service'

module Analytics
  # Executing specified commands for analytics
  module AnalyticsExecution
    EXECUTIONS_LIST = {
      specific_grades: -> { SpecificSemesterAnalyticsService.new(type: :specific_grades).call },
      specific_uncompleted: -> { SpecificSemesterAnalyticsService.new(type: :specific_uncompleted).call },
      specific_full: -> { SpecificSemesterAnalyticsService.new(type: :specific_full).call },
      active_grades: -> { ActiveSemestersAnalyticsService.new(type: :active_grades).call },
      active_uncompleted: -> { ActiveSemestersAnalyticsService.new(type: :active_uncompleted).call },
      active_full: -> { ActiveSemestersAnalyticsService.new(type: :active_full).call },
      completed_grades: -> { CompletedSemestersAnalyticsService.new(type: :completed_grades).call },
      completed_full: -> { CompletedSemestersAnalyticsService.new(type: :completed_full).call }
    }.freeze

    def self.execute(operation:)
      Utilities::LinesCleaner.instance.clear_lines
      EXECUTIONS_LIST[operation].call

      MenuConfig::Config.display_menu(:analytics)
    end
  end
end

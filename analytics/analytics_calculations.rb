# frozen_string_literal: true

module Analytics
  # Module containing methods for calculating values connected with analytics output
  module AnalyticsCalculations
    def count_lab_works(id:, status:)
      case status
      when :all
        Queries::SemestersQuery.new.count_total_lab_works(id: id)
      when :completed
        Queries::SemestersQuery.new.count_completed_lab_works(id: id)
      else
        raise 'Wrong status!'
      end
    end

    def count_completed_lab_works_percentage(id:)
      total_number = count_lab_works(id: id, status: :all)
      completed_number = count_lab_works(id: id, status: :completed)

      total_number.zero? ? 0 : (completed_number / total_number.to_f * 100).round
    end
  end
end

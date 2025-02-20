# frozen_string_literal: true

module Analytics
  # Module containing methods for calculating values connected with analytics output
  module AnalyticsCalculations
    def count_total_lab_works_mumber(id:)
      total_labs_number = 0
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
        Queries::LabsQuery.new.ids_by_discipline_id(discipline_id: discipline_id).each do |_lab_id|
          total_labs_number += 1
        end
      end

      total_labs_number
    end

    def count_completed_lab_works_number(id:)
      completed_lab_works = 0
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
        Queries::LabsQuery.new.ids_by_discipline_id(discipline_id: discipline_id).flatten.each do |lab_id|
          completed_lab_works += 1 if Queries::LabsQuery.new.status(id: lab_id) == 'completed'
        end
      end

      completed_lab_works
    end

    def count_completed_lab_works_percentage(id:)
      total_number = count_total_lab_works_mumber(id: id)
      completed_number = count_completed_lab_works_number(id: id)

      total_number.zero? ? 0 : (completed_number / total_number.to_f * 100).round
    end
  end
end

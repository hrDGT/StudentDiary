# frozen_string_literal: true

module Analytics
  # A module containing methods for calling the corresponding analytics
  module AnalyticsOperations
    def print_discipline_average_grades_analytics(id:)
      print_semester_name(id: id)
      print_disciplines_with_average_grades(id: id)
    end

    def print_uncompleted_lab_analytics(id:)
      print_semester_name(id: id)
      print_not_completed_lab_works(id: id)
    end

    def print_semester_analytics(id:)
      print_semester_name(id: id)
      print_semester_status(id: id)
      puts '---------------------'
      print_disciplines_info(id: id)
      print_overall_average_grade(id: id)
      print_total_lab_works_number(id: id)
      print_completed_lab_works_percentage(id: id)

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end
  end
end

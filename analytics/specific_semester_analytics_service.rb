# frozen_string_literal: true

module Analytics
  # Service class to get analytics for a specific semester
  class SpecificSemesterAnalyticsService
    include AnalyticsPrint
    include AnalyticsCalculations
    include AnalyticsOperations

    def initialize(type:)
      @type = type
    end

    def call
      process_user_input

      process_analytics(type: ANALYTICS_TYPES[@type])
    end

    private

    ANALYTICS_TYPES = {
      specific_grades: :print_discipline_average_grades_analytics,
      specific_uncompleted: :print_uncompleted_lab_analytics,
      specific_overdue: :print_overdue_lab_analytics,
      specific_full: :print_semester_analytics
    }.freeze

    def process_analytics(type:)
      return send(type, id: @form.id) if @form.valid?

      handle_errors
    end

    def process_user_input
      puts 'Введите название семестра, по которому хотите получить аналитику'
      name = gets.chomp
      id = Queries::SemestersQuery.id_by_name(name: name)
      @form = AnalyticsForm.new(id: id)

      Utilities::LinesCleaner.instance.lines_to_clear += 2
    end

    def handle_errors
      puts 'Ошибки ввода:'
      puts @form.errors

      Utilities::LinesCleaner.instance.lines_to_clear += 1 + @form.errors.size
    end
  end
end

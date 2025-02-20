# frozen_string_literal: true

module Analytics
  # Service class to get analytics for a specific semester
  class SpecificSemesterAnalyticsService
    include AnalyticsProcess
    include AnalyticsCalculations
    include AnalyticsOperations

    def initialize(type:)
      @type = type
    end

    def call
      process_user_input

      send(ANALYTICS_TYPES[@type])
    end

    private

    ANALYTICS_TYPES = {
      specific_grades: :process_average_grades_analytics,
      specific_uncompleted: :process_uncompleted_labs_analytics,
      specific_full: :process_full_analytics
    }.freeze

    def process_average_grades_analytics
      if @form.valid?
        print_discipline_average_grades_analytics(id: @form.id)
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 1 + @form.errors.size
      end
    end

    def process_uncompleted_labs_analytics
      if @form.valid?
        print_uncompleted_lab_analytics(id: @form.id)
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 1 + @form.errors.size
      end
    end

    def process_full_analytics
      if @form.valid?
        print_semester_analytics(id: @form.id)
      else
        puts 'Ошибки ввода:'
        puts @form.errors

        Utilities::LinesCleaner.instance.lines_to_clear += 1 + @form.errors.size
      end
    end

    def process_user_input
      puts 'Введите id семестра, по которому хотите получить аналитику'
      id = gets.chomp
      @form = AnalyticsForm.new(id: id)

      Utilities::LinesCleaner.instance.lines_to_clear += 2
    end
  end
end

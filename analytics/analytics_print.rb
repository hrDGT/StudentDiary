# frozen_string_literal: true

module Analytics
  # Module containing the logic for outputting the analytics
  module AnalyticsPrint
    def print_semester_name(id:)
      print 'Semester: '
      puts Semester.new(id: id).name

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_semester_status(id:)
      print 'Status: '
      puts Semester.new(id: id).status

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_disciplines_info(id:)
      discipline_ids = Queries::SemestersQuery.discipline_ids_by_id(id: id)
      return discipline_ids.each { |discipline_id| print_discipline_details(id: discipline_id) } if discipline_ids.any?

      puts 'No disciplines found'
      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_discipline_details(id:)
      print 'Discipline: '
      print_disicipline_name(discipline_id: id)
      print '  - Average Grade: '
      print_discipline_average_grade(discipline_id: id)
      puts '  - Lab Works:'
      print_lab_works(discipline_id: id)
      puts '---------------------'

      Utilities::LinesCleaner.instance.lines_to_clear += 2
    end

    def print_disicipline_name(discipline_id:)
      puts Discipline.new(id: discipline_id).name

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_discipline_average_grade(discipline_id:)
      grades = Queries::DisciplinesQuery.grades_by_id(id: discipline_id).map(&:to_i).reject(&:zero?)
      puts (grades.empty? ? 0 : grades.reduce(0) { |avg, grade| avg + grade }.to_f / grades.size).round

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_overall_average_grade(id:)
      all_grades_array = Queries::SemestersQuery.all_grades(id: id)
      overall_average_grade = all_grades_array.reduce(0) { |sum, grade| sum + grade }.to_f / all_grades_array.size
      puts "Overall average grade: #{all_grades_array.empty? ? 0 : overall_average_grade.round}"

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_disciplines_with_average_grades(id:)
      Queries::SemestersQuery.discipline_ids_by_id(id: id).each do |discipline_id|
        print 'Discipline: '
        print_disicipline_name(discipline_id: discipline_id)
        print '  - Average Grade: '
        print_discipline_average_grade(discipline_id: discipline_id)
      end
    end

    def print_lab_works(discipline_id:)
      lab_ids = Queries::DisciplinesQuery.lab_ids_by_id(id: discipline_id)
      return lab_ids.each { |lab_id| print_lab_details(id: lab_id) } if lab_ids.any?

      puts "\tNo labs found"
      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_lab_details(id:)
      model = Lab.new(id: id)
      print "\t[#{model.status}] #{model.name} "
      print_lab_postscript(model: model)

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_total_lab_works_number(id:)
      puts "Total number of lab works: #{count_lab_works(id: id, status: :all)}"

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_completed_lab_works_number(id:)
      puts "Number of completed lab works: #{count_lab_works(id: id, status: :completed)}"
    end

    def print_completed_lab_works_percentage(id:)
      puts "Percentage of completed lab works: #{count_completed_lab_works_percentage(id: id)}%"

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_not_completed_lab_works(id:)
      Queries::SemestersQuery.new.not_completed_lab_works(id: id).each do |lab_id|
        model = Lab.new(id: lab_id)
        print "  - #{model.name} "
        print_lab_postscript(model: model)

        Utilities::LinesCleaner.instance.lines_to_clear += 1
      end
    end

    def print_overdue_lab_works(id:)
      Queries::SemestersQuery.new.overdue_lab_works(id: id).each do |lab_id|
        model = Lab.new(id: lab_id)
        print "  - #{model.name} "
        print_lab_postscript(model: model)

        Utilities::LinesCleaner.instance.lines_to_clear += 1
      end
    end

    def print_lab_postscript(model:)
      return puts "(Deadline: #{model.deadline})" if model.active?

      grade = model.grade

      grade.nil? ? (puts '(Grade: unknown)') : (puts "(Grade: #{grade})")
    end
  end
end

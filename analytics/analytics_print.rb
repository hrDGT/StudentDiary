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
      Queries::SemestersQuery.discipline_ids_by_id(id: id).each do |discipline_id|
        print 'Discipline: '
        print_disicipline_name(discipline_id: discipline_id)
        print '  - Average Grade: '
        print_discipline_average_grade(discipline_id: discipline_id)
        puts '  - Lab Works:'
        print_lab_works(discipline_id: discipline_id)
        puts '---------------------'

        Utilities::LinesCleaner.instance.lines_to_clear += 2
      end
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
      Queries::DisciplinesQuery.lab_ids_by_id(id: discipline_id).each do |lab_id|
        query = Lab.new(id: lab_id)
        print "\t[#{query.status}] "
        print "#{query.name} "
        print_lab_postscript(query: query)

        Utilities::LinesCleaner.instance.lines_to_clear += 1
      end
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
        query = Lab.new(id: lab_id)
        print "  - #{query.name} "
        print_lab_postscript(query: query)

        Utilities::LinesCleaner.instance.lines_to_clear += 1
      end
    end

    def print_lab_postscript(query:)
      return puts "(Deadline: #{query.deadline})" if query.active?

      grade = query.grade

      grade.nil? ? (puts '(Grade: unknown)') : (puts "(Grade: #{grade})")
    end
  end
end

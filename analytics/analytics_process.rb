# frozen_string_literal: true

module Analytics
  # Module containing the logic for outputting the analytics
  module AnalyticsProcess
    def print_semester_name(id:)
      print 'Semester: '
      puts Queries::SemestersQuery.new.name(id: id)

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_semester_status(id:)
      print 'Status: '
      puts Queries::SemestersQuery.new.status(id: id)

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_disciplines_info(id:)
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
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
      puts Queries::DisciplinesQuery.new.name(id: discipline_id)

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_discipline_average_grade(discipline_id:)
      grades = Queries::LabsQuery.new.grades_by_discipline_id(discipline_id: discipline_id)
                                 .flatten.map(&:to_i).reject(&:zero?)
      puts (grades.empty? ? 0 : grades.reduce(0) { |avg, grade| avg + grade }.to_f / grades.size).round

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_overall_average_grade(id:)
      all_grades_array = all_discipline_grades(id: id)
      overall_average_grade = all_grades_array.reduce(0) { |sum, grade| sum + grade }.to_f / all_grades_array.size
      puts(all_discipline_grades(id: id).empty? ? 0 : "Overall average grade: #{overall_average_grade.round}")

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def all_discipline_grades(id:)
      all_grades = []
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
        grades = Queries::LabsQuery.new.grades_by_discipline_id(discipline_id: discipline_id)
        all_grades << grades.flatten.map(&:to_i)
      end

      all_grades.flatten
    end

    def print_disciplines_with_average_grades(id:)
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
        print 'Discipline: '
        print_disicipline_name(discipline_id: discipline_id)
        print '  - Average Grade: '
        print_discipline_average_grade(discipline_id: discipline_id)
      end
    end

    def print_lab_works(discipline_id:)
      Queries::LabsQuery.new.ids_by_discipline_id(discipline_id: discipline_id).flatten.each do |lab_id|
        print "\t[#{Queries::LabsQuery.new.status(id: lab_id)}] "
        print "#{Queries::LabsQuery.new.name(id: lab_id)} "
        print_lab_postscript(lab_id: lab_id)

        Utilities::LinesCleaner.instance.lines_to_clear += 1
      end
    end

    def print_total_lab_works_number(id:)
      puts "Total number of lab works: #{count_total_lab_works_mumber(id: id)}"

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_completed_lab_works_number(id:)
      puts "Number of completed lab works: #{count_completed_lab_works_number(id: id)}"
    end

    def print_completed_lab_works_percentage(id:)
      puts "Percentage of completed lab works: #{count_completed_lab_works_percentage(id: id)}%"

      Utilities::LinesCleaner.instance.lines_to_clear += 1
    end

    def print_uncompleted_lab_works(id:)
      Queries::DisciplinesQuery.new.ids_by_semester_id(semester_id: id).flatten.each do |discipline_id|
        Queries::LabsQuery.new.ids_by_discipline_id(discipline_id: discipline_id).flatten.each do |lab_id|
          next unless Queries::LabsQuery.new.status(id: lab_id) == 'not completed'

          print "  - #{Queries::LabsQuery.new.name(id: lab_id)} "
          print_lab_postscript(lab_id: lab_id)

          Utilities::LinesCleaner.instance.lines_to_clear += 1
        end
      end
    end

    def print_lab_postscript(lab_id:)
      if Queries::LabsQuery.new.active?(id: lab_id)
        puts "(Deadline: #{Queries::LabsQuery.new.deadline(id: lab_id)})"
      else
        grade = Queries::LabsQuery.new.grade(id: lab_id)
        grade.nil? ? (puts '(Grade: unknown)') : (puts "(Grade: #{grade})")
      end
    end
  end
end

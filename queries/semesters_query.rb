# frozen_string_literal: true

module Queries
  # Semesters-related queries
  class SemestersQuery
    def display_list
      Database::Database.instance.execute_query(
        query: 'SELECT * FROM semesters'
      ).each { |row| puts row.values.join(' ') }
    end

    def count_total_lab_works(id:)
      Database::Database.instance.execute_query(
        query: <<-SQL,
          SELECT
            COUNT(labs.id)
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id JOIN semesters ON disciplines.semester_id = semesters.id
          WHERE semesters.id = $1
        SQL
        values: [id]
      )[0]['count'].to_i
    end

    def count_completed_lab_works(id:)
      Database::Database.instance.execute_query(
        query: <<-SQL,
          SELECT
            COUNT(labs.id)
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id JOIN semesters ON disciplines.semester_id = semesters.id
          WHERE semesters.id = $1 AND labs.status = 'completed'
        SQL
        values: [id]
      )[0]['count'].to_i
    end

    def not_completed_lab_works(id:)
      Database::Database.instance.execute_query(
        query: <<-SQL,
          SELECT
            labs.id
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id JOIN semesters ON disciplines.semester_id = semesters.id
          WHERE semesters.id = $1 AND labs.status = 'not completed'
        SQL
        values: [id]
      ).values.flatten
    end

    def all_ids(status:)
      case status
      when :completed
        Database::Database.instance.execute_query(
          query: 'SELECT id FROM semesters WHERE end_date < CURRENT_DATE'
        ).values.flatten
      when :active
        Database::Database.instance.execute_query(
          query: 'SELECT id FROM semesters WHERE end_date >= CURRENT_DATE'
        ).values.flatten
      end
    end

    class << self
      def discipline_ids_by_id(id:)
        Database::Database.instance.execute_query(query: 'SELECT id FROM disciplines WHERE semester_id = $1',
                                                  values: [id]).values.flatten
      end

      def all_grades(id:)
        Database::Database.instance.execute_query(
          query: <<-SQL,
            SELECT
              labs.grade
            FROM
              labs JOIN disciplines ON labs.discipline_id = disciplines.id JOIN semesters ON disciplines.semester_id = semesters.id
            WHERE semesters.id = $1 AND labs.grade IS NOT NULL
          SQL
          values: [id]
        ).values.flatten.map(&:to_i)
      end
    end
  end
end

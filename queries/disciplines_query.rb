# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class DisciplinesQuery
    def display_list
      Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            CONCAT(disciplines.name, ' — ', semesters.name)
          FROM
            disciplines JOIN semesters ON disciplines.semester_id = semesters.id
        SQL
      ).each { |row| puts row.values.join(' ') }
    end

    class << self
      def id_by_name_and_semester(name:, semester_id:)
        result = Database::Database.instance.execute_query(
          query: <<-SQL,
            SELECT id
            FROM disciplines
            WHERE name = $1 AND semester_id = $2
          SQL
          values: [name, semester_id]
        )
        result.ntuples.zero? ? nil : result.getvalue(0, 0)
      end

      def name_exists_in_semester?(name:, semester_id:)
        Database::Database.instance.execute_query(
          query: <<-SQL,
            SELECT
              name
            FROM
              disciplines
            WHERE name = $1 AND semester_id = $2
          SQL
          values: [name, semester_id]
        ).ntuples.positive?
      end

      def grades_by_id(id:)
        Database::Database.instance.execute_query(query: 'SELECT grade FROM labs WHERE discipline_id = $1',
                                                  values: [id]).values.flatten
      end

      def lab_ids_by_id(id:)
        Database::Database.instance.execute_query(query: 'SELECT id FROM labs WHERE discipline_id = $1',
                                                  values: [id]).values.flatten
      end
    end
  end
end

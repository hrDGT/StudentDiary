# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class DisciplinesQuery
    def display_list
      result = Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            disciplines.id, CONCAT(disciplines.name, ' — ', semesters.id), semesters.name
          FROM
            disciplines JOIN semesters ON disciplines.semester_id = semesters.id
        SQL
      )

      result.each { |row| puts row.values.join(' ') }
    end

    def exists?(id:)
      Database::Database.instance.execute_query(query: 'SELECT * FROM disciplines WHERE id = $1',
                                                values: [id]).ntuples.positive?
    end

    def ids_by_semester_id(semester_id:)
      Database::Database.instance.execute_query(query: 'SELECT id FROM disciplines WHERE semester_id = $1',
                                                values: [semester_id]).values
    end

    def name(id:)
      Database::Database.instance.execute_query(
        query: 'SELECT name FROM disciplines WHERE id = $1', values: [id]
      ).getvalue(0, 0)
    end
  end
end

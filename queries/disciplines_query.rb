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
  end
end

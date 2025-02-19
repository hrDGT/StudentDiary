# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class LabsQuery
    def display_list
      result = Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            labs.id, labs.name AS lab_name, labs.deadline, labs.status, CONCAT(labs.grade, ' — ', disciplines.id), disciplines.name AS discipline_name
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id
        SQL
      )

      result.each { |row| puts row.values.join(' ') }
    end

    def exists?(id:)
      Database::Database.instance.execute_query(query: 'SELECT * FROM labs WHERE id = $1',
                                                values: [id]).ntuples.positive?
    end
  end
end

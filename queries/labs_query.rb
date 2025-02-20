# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class LabsQuery
    def display_list
      Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            labs.id, labs.name AS lab_name, labs.deadline, labs.status, CONCAT(labs.grade, ' — ', disciplines.id), disciplines.name AS discipline_name
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id
        SQL
      ).each { |row| puts row.values.join(' ') }
    end
  end
end

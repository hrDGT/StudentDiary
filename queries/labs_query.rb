# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class LabsQuery
    def display_list
      Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            labs.name, labs.deadline, labs.status, CONCAT(labs.grade, ' — ', disciplines.name)
          FROM
            labs JOIN disciplines ON labs.discipline_id = disciplines.id
        SQL
      ).each { |row| puts row.values.join(' ') }
    end

    class << self
      def id_by_name_and_disicpline(name:, discipline_id:)
        result = Database::Database.instance.execute_query(
          query: <<-SQL,
            SELECT id
            FROM labs
            WHERE name = $1 AND discipline_id = $2
          SQL
          values: [name, discipline_id]
        )
        result.ntuples.zero? ? nil : result.getvalue(0, 0)
      end
    end
  end
end

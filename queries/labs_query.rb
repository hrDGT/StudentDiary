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

    def status(id:)
      Database::Database.instance.execute_query(
        query: 'SELECT status FROM labs WHERE id = $1', values: [id]
      ).getvalue(0, 0)
    end

    def name(id:)
      Database::Database.instance.execute_query(query: 'SELECT name FROM labs WHERE id = $1', values: [id]).getvalue(0,
                                                                                                                     0)
    end

    def active?(id:)
      current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)
      deadline = Database::Database.instance.execute_query(
        query: 'SELECT deadline FROM labs WHERE id = $1', values: [id]
      ).getvalue(0, 0)

      current_date < deadline
    end

    def deadline(id:)
      Database::Database.instance.execute_query(
        query: 'SELECT deadline FROM labs WHERE id = $1', values: [id]
      ).getvalue(0, 0)
    end

    def grade(id:)
      Database::Database.instance.execute_query(
        query: 'SELECT grade FROM labs WHERE id = $1', values: [id]
      ).getvalue(0, 0)
    end

    def grades_by_discipline_id(discipline_id:)
      Database::Database.instance.execute_query(query: 'SELECT grade FROM labs WHERE discipline_id = $1',
                                                values: [discipline_id]).values
    end

    def ids_by_discipline_id(discipline_id:)
      Database::Database.instance.execute_query(query: 'SELECT id FROM labs WHERE discipline_id = $1',
                                                values: [discipline_id]).values
    end
  end
end

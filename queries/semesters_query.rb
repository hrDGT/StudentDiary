# frozen_string_literal: true

module Queries
  # Semesters-related queries
  class SemestersQuery
    def display_list
      result = Database::Database.instance.execute_query(query: 'SELECT * FROM semesters')

      result.each { |row| puts row.values.join(' ') }
    end

    def exists?(id:)
      Database::Database.instance.execute_query(query: 'SELECT * FROM semesters WHERE id = $1',
                                                values: [id]).ntuples.positive?
    end

    def name(id:)
      Database::Database.instance.execute_query(
        query: 'SELECT name FROM semesters WHERE id = $1', values: [id]
      ).getvalue(0, 0)
    end

    def status(id:)
      current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)
      end_date = Database::Database.instance.execute_query(
        query: 'SELECT end_date FROM semesters WHERE id = $1', values: [id]
      ).getvalue(0, 0)

      current_date < end_date ? 'Active' : 'Completed'
    end

    def all_ids
      Database::Database.instance.execute_query(query: 'SELECT id FROM semesters').values
    end
  end
end

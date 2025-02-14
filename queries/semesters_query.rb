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
  end
end

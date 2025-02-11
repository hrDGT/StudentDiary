# frozen_string_literal: true

require_relative '../database/database'

module Queries
  # Display all values from specified table
  class IfSemesterExists
    def execute(id:)
      Database::Database.instance.execute_query(query: 'SELECT * FROM semesters WHERE id = $1',
                                                values: [id]).ntuples.positive?
    end
  end
end

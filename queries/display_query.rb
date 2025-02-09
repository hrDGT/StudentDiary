# frozen_string_literal: true

require_relative '../database/database'

module Queries
  # Display all values from specified table
  class DisplayQuery
    def initialize(table:)
      @table = table
    end

    def execute
      result = Database::Database.instance.execute_query(query: "SELECT * FROM #{@table}")

      result.each { |row| puts row.values.join(' ') }
    end
  end
end

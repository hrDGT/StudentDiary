# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Display all names
  class DisplayCommand < Command
    def initialize(table:)
      super
      @table = table
    end

    def execute
      result = Database::Database.execute_query(
        "SELECT name FROM #{@table}"
      )
      result.each { |row| puts row.values.join(' ') }

      result
    end
  end
end

# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Delete a record in a table by name
  class DeleteCommand < Command
    def initialize(table:, name:)
      super
      @table = table
      @name = name
    end

    def execute
      Database::Database.execute_query(
        "DELETE FROM #{@table} WHERE name = '#{@name}'"
      )
    end
  end
end

# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Delete a record in a table by id
  class DeleteCommand < Command
    def initialize(table:, id:)
      super()
      @table = table
      @id = id
    end

    def execute
      query = "DELETE FROM #{@table} WHERE id = $1"

      Database::Database.instance.execute_query(query: query, values: [@id])
    end
  end
end

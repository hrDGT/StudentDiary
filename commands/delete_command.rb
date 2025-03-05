# frozen_string_literal: true

require_relative 'command'

module Commands
  # Delete a record in a table by id
  class DeleteCommand < Command
    def initialize(table:, id:)
      super()
      @table = table
      @id = id
    end

    def execute
      Database::Database.instance.execute_query(query: "DELETE FROM #{@table} WHERE id = $1", values: [@id])
    end
  end
end

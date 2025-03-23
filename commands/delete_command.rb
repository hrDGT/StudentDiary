# frozen_string_literal: true

require_relative 'command'

module Commands
  # Delete a record in a table by id
  class DeleteCommand < Command
    def initialize(table:, id:, additional_info: nil)
      super()
      @table = table
      @id = id
      @additional_info = additional_info
    end

    def execute
      query = "DELETE FROM #{@table} WHERE id = $1"
      values = [@id]
      if @additional_info
        query += " AND #{@additional_info.keys[0]} = $2"
        values << @additional_info.values[0]
      end

      Database::Database.instance.execute_query(query: query, values: values)
    end
  end
end

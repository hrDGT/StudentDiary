# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Add a record to the table
  class AddCommand < Command
    def initialize(table:, **params)
      super
      @table = table
      @params = params
    end

    def execute
      Database::Database.execute_query(
        "INSERT INTO #{@table} (#{@params.keys.join(', ')}) VALUES ('#{@params.values.join("', '")}')"
      )
    end
  end
end

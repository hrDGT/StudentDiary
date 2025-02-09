# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Add a record to a table
  class AddCommand < Command
    def initialize(table:, **params)
      super()
      @table = table
      @params = params
    end

    def execute
      columns = @params.keys.join(', ')
      values_placeholders = @params.keys.map { |key| "$#{@params.keys.index(key) + 1}" }.join(', ')
      values = @params.values

      query = "INSERT INTO #{@table} (#{columns}) VALUES (#{values_placeholders})"

      Database::Database.instance.execute_query(query: query, values: values)
    end
  end
end

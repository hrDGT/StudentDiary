# frozen_string_literal: true

require_relative 'command'

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

      Database::Database.instance.execute_query(
        query: "INSERT INTO #{@table} (#{columns}) VALUES (#{values_placeholders})",
        values: values
      )
    end
  end
end

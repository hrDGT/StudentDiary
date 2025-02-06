# frozen_string_literal: true

require_relative 'command'
require_relative '../database/database'

module Commands
  # Edit a record in a table by name
  class EditCommand < Command
    def initialize(table:, updates:, name:)
      super
      @table = table
      @updates = updates
      @name = name
    end

    def execute
      new_data = @updates.map { |col, value| "#{col} = '#{value}'" }.join(', ')
      Database::Database.execute_query(
        "UPDATE #{@table} SET #{new_data} WHERE name = '#{@name}'"
      )
    end
  end
end

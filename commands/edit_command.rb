# frozen_string_literal: true

require_relative 'command'

module Commands
  # Edit a record in a table by id
  class EditCommand < Command
    def initialize(table:, id:, updates:)
      super()
      @table = table
      @id = id
      @updates = updates
    end

    def execute
      updates_set = @updates.keys.each_with_index.map { |column, index| "#{column} = $#{index + 1}" }.join(', ')
      values = @updates.values << @id

      Database::Database.instance.execute_query(
        query: "UPDATE #{@table} SET #{updates_set} WHERE id = $#{values.size}",
        values: values
      )
    end
  end
end

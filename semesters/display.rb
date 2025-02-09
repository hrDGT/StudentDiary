# frozen_string_literal: true

require_relative '../queries/display_query'
require_relative 'execution'

module Semesters
  # Service class for displaying semesters from the table
  class DisplaySemestersService
    def call
      extra_lines = display_semesters

      Execution.instance_variable_set(:@lines_to_clear, extra_lines)
    end

    private

    def display_semesters
      command = Queries::DisplayQuery.new(table: 'semesters')
      command.execute.ntuples
    end
  end
end

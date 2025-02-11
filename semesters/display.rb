# frozen_string_literal: true

require_relative '../queries/display_query'
require_relative 'execution'

module Semesters
  # Service class for displaying semesters from the table
  class DisplaySemestersService
    def call
      Execution.instance_variable_set(:@lines_to_clear, display_semesters)
    end

    private

    def display_semesters
      Queries::DisplayQuery.new(table: 'semesters').execute.ntuples
    end
  end
end

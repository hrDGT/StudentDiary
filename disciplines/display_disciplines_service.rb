# frozen_string_literal: true

module Disciplines
  # Service class for displaying disciplines from the table
  class DisplayDisciplinesService
    def call
      Utilities::LinesCleaner.instance.lines_to_clear += display_disciplines
    end

    private

    def display_disciplines
      Queries::DisciplinesQuery.new.display_list.ntuples
    end
  end
end

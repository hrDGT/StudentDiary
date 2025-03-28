# frozen_string_literal: true

module Semesters
  # Service class for displaying semesters from the table
  class DisplaySemestersService
    def call
      Utilities::LinesCleaner.instance.lines_to_clear += display_semesters
    end

    private

    def display_semesters
      Queries::SemestersQuery.new.display_list.ntuples
    end
  end
end

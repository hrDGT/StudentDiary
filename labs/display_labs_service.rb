# frozen_string_literal: true

module Labs
  # Service class for displaying labs from the table
  class DisplayLabsService
    def call
      Utilities::LinesCleaner.instance.lines_to_clear += display_labs
    end

    private

    def display_labs
      Queries::LabsQuery.new.display_list.ntuples
    end
  end
end

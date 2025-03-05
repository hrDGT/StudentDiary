# frozen_string_literal: true

require_relative '../semester'
require_relative '../queries/semesters_query'
require_relative 'semesters_form'
require_relative 'add_new_semester_service'
require_relative 'delete_semester_service'
require_relative 'display_semesters_service'
require_relative 'edit_semester_service'

module Semesters
  # Executing specified commands for semesters table
  module SemestersExecution
    EXECUTIONS_LIST = {
      add: -> { AddNewSemesterService.new.call },
      delete: -> { DeleteSemesterService.new.call },
      display: -> { DisplaySemestersService.new.call },
      edit: -> { EditSemesterService.new.call }
    }.freeze

    def self.execute(operation:)
      Utilities::LinesCleaner.instance.clear_lines
      EXECUTIONS_LIST[operation].call

      MenuConfig::Config.display_menu(:semesters)
    end
  end
end

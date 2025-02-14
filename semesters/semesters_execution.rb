# frozen_string_literal: true

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
      add: -> { AddNewSemesterService.new },
      delete: -> { DeleteSemesterService.new },
      display: -> { DisplaySemestersService.new },
      edit: -> { EditSemesterService.new }
    }.freeze

    def self.execute(operation:)
      Utilities::LinesCleaner.instance.clear_lines(quantity: 0)
      service = EXECUTIONS_LIST[operation].call
      service.call

      MenuConfig::Config.display_menu(:semesters)
    end
  end
end

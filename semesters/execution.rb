# frozen_string_literal: true

require_relative 'add'
require_relative 'delete'
require_relative 'display'
require_relative 'edit'
require_relative '../utilities/clear_lines'

module Semesters
  # Executing specified commands for semesters table
  module Execution
    extend ClearLines
    @lines_to_clear ||= 0

    EXECUTIONS_LIST = {
      add: -> { AddNewSemesterService.new },
      delete: -> { DeleteSemesterService.new },
      display: -> { DisplaySemestersService.new },
      edit: -> { EditSemesterService.new }
    }.freeze

    def self.execute(operation:)
      clear_lines(@lines_to_clear)
      service = EXECUTIONS_LIST[operation].call
      service.call

      MenuConfig::Config.display_menu(:semesters)
    end

    def self.extra_lines
      @lines_to_clear
    end
  end
end

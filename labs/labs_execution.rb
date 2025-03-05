# frozen_string_literal: true

require_relative '../lab'
require_relative '../discipline'
require_relative '../queries/labs_query'
require_relative '../queries/disciplines_query'
require_relative 'labs_form'
require_relative 'add_new_lab_service'
require_relative 'delete_lab_service'
require_relative 'display_labs_service'
require_relative 'edit_lab_service'

module Labs
  # Executing specified commands for labs table
  module LabsExecution
    EXECUTIONS_LIST = {
      add: -> { AddNewLabService.new },
      delete: -> { DeleteLabService.new },
      display: -> { DisplayLabsService.new },
      edit: -> { EditLabService.new }
    }.freeze

    def self.execute(operation:)
      Utilities::LinesCleaner.instance.clear_lines
      service = EXECUTIONS_LIST[operation].call
      service.call

      MenuConfig::Config.display_menu(:labs)
    end
  end
end

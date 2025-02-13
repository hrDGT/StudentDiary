# frozen_string_literal: true

require_relative '../queries/semesters_query'
require_relative 'form'
require_relative 'add'
require_relative 'delete'
require_relative 'display'
require_relative 'edit'

module Semesters
  # Executing specified commands for semesters table
  module Execution
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

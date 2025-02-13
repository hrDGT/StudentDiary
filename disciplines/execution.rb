# frozen_string_literal: true

require_relative '../queries/disciplines_query'
require_relative 'form'
require_relative 'add'
require_relative 'delete'
require_relative 'display'
require_relative 'edit'

module Disciplines
  # Executing specified commands for disciplines table
  module Execution
    EXECUTIONS_LIST = {
      add: -> { AddNewDisciplineService.new },
      delete: -> { DeleteDisciplineService.new },
      display: -> { DisplayDisciplinesService.new },
      edit: -> { EditDisciplineService.new }
    }.freeze

    def self.execute(operation:)
      Utilities::LinesCleaner.instance.clear_lines(quantity: 0)
      service = EXECUTIONS_LIST[operation].call
      service.call

      MenuConfig::Config.display_menu(:disciplines)
    end
  end
end

# frozen_string_literal: true

require_relative '../queries/disciplines_query'
require_relative 'disciplines_form'
require_relative 'add_new_discipline_service'
require_relative 'delete_discipline_service'
require_relative 'display_disciplines_service'
require_relative 'edit_discipline_service'

module Disciplines
  # Executing specified commands for disciplines table
  module DisciplinesExecution
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

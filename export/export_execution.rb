# frozen_string_literal: true

require_relative 'export_form'
require_relative 'export_service'

module Export
  # Executing specified commands for export
  module ExportExecution
    def self.execute
      Utilities::LinesCleaner.instance.clear_lines
      Export::ExportService.new.call

      MenuConfig::Config.display_menu(:export)
    end
  end
end

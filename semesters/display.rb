# frozen_string_literal: true

require_relative '../commands/display_command'
require_relative 'execution'

module Semesters
  # Specified display command for semesters table
  module Display
    def self.display
      command = Commands::DisplayCommand.new(table: 'semesters')
      extra_lines = command.execute.ntuples

      Semesters::Execution.instance_variable_set(:@lines_to_clear, extra_lines)
    end
  end
end

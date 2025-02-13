# frozen_string_literal: true

require_relative '../semesters/execution'
require_relative '../disciplines/execution'

module MenuConfig
  module Matches
    SEMESTERS = {
      '1' => -> { Semesters::Execution.execute(operation: :display) },
      '2' => -> { Semesters::Execution.execute(operation: :add) },
      '3' => -> { Semesters::Execution.execute(operation: :edit) },
      '4' => -> { Semesters::Execution.execute(operation: :delete) },
      '5' => -> { Config.display_menu(:main) }
    }.freeze

    DISCIPLINES = {
      '1' => -> { Disciplines::Execution.execute(operation: :display) },
      '2' => -> { Disciplines::Execution.execute(operation: :add) },
      '3' => -> { Disciplines::Execution.execute(operation: :edit) },
      '4' => -> { Disciplines::Execution.execute(operation: :delete) },
      '5' => -> { Config.display_menu(:main) }
    }.freeze

    LABS = {
      '1' => -> { puts 'labs number 1' },
      '2' => -> { puts 'labs number 2' },
      '3' => -> { puts 'labs number 3' },
      '4' => -> { Config.display_menu(:main) }
    }.freeze

    ANALYTICS = {
      '1' => -> { puts 'analytics number 1' },
      '2' => -> { puts 'analytics number 2' },
      '3' => -> { puts 'analytics number 3' },
      '4' => -> { Config.display_menu(:main) }
    }.freeze

    EXPORT = {
      '1' => -> { puts 'export number 1' },
      '2' => -> { Config.display_menu(:main) }
    }.freeze

    MAIN = {
      '1' => -> { Config.display_menu(:semesters) },
      '2' => -> { Config.display_menu(:disciplines) },
      '3' => -> { Config.display_menu(:labs) },
      '4' => -> { Config.display_menu(:analytics) },
      '5' => -> { Config.display_menu(:export) }
    }.freeze
  end
end

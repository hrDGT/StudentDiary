# frozen_string_literal: true

require_relative '../semesters/semesters_execution'
require_relative '../disciplines/disciplines_execution'
require_relative '../labs/labs_execution'

module MenuConfig
  module Matches
    SEMESTERS = {
      '1' => -> { Semesters::SemestersExecution.execute(operation: :display) },
      '2' => -> { Semesters::SemestersExecution.execute(operation: :add) },
      '3' => -> { Semesters::SemestersExecution.execute(operation: :edit) },
      '4' => -> { Semesters::SemestersExecution.execute(operation: :delete) },
      '5' => -> { Config.display_menu(:main) }
    }.freeze

    DISCIPLINES = {
      '1' => -> { Disciplines::DisciplinesExecution.execute(operation: :display) },
      '2' => -> { Disciplines::DisciplinesExecution.execute(operation: :add) },
      '3' => -> { Disciplines::DisciplinesExecution.execute(operation: :edit) },
      '4' => -> { Disciplines::DisciplinesExecution.execute(operation: :delete) },
      '5' => -> { Config.display_menu(:main) }
    }.freeze

    LABS = {
      '1' => -> { Labs::LabsExecution.execute(operation: :display) },
      '2' => -> { Labs::LabsExecution.execute(operation: :add) },
      '3' => -> { Labs::LabsExecution.execute(operation: :edit) },
      '4' => -> { Labs::LabsExecution.execute(operation: :delete) },
      '5' => -> { Config.display_menu(:main) }
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

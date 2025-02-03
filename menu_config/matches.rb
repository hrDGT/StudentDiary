# frozen_string_literal: true

module MenuConfig
  module Matches
    SEMESTERS = {
      '1' => -> { puts 'semesters number 1' },
      '2' => -> { puts 'semesters number 2' },
      '3' => -> { puts 'semesters number 3' },
      '4' => -> { Config.display_menu(:main) }
    }.freeze

    LABS = {
      '1' => -> { puts 'labs number 1' },
      '2' => -> { puts 'labs number 2' },
      '3' => -> { puts 'labs number 3' },
      '4' => -> { Config.display_menu(:main) }
    }.freeze

    DISCIPLINES = {
      '1' => -> { puts 'disciplines number 1' },
      '2' => -> { puts 'disciplines number 2' },
      '3' => -> { puts 'disciplines number 3' },
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
      '2' => -> { Config.display_menu(:labs) },
      '3' => -> { Config.display_menu(:disciplines) },
      '4' => -> { Config.display_menu(:analytics) },
      '5' => -> { Config.display_menu(:export) }
    }.freeze
  end
end

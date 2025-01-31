# frozen_string_literal: true

module MenuConfig
  module Matches
    SEMESTERS = {
      '1' => -> { puts 'semesters number 1' },
      '2' => -> { puts 'semesters number 2' },
      '3' => -> { puts 'semesters number 3' },
      '4' => -> { Config.main_menu.display_options }
    }.freeze

    LABS = {
      '1' => -> { puts 'labs number 1' },
      '2' => -> { puts 'labs number 2' },
      '3' => -> { puts 'labs number 3' },
      '4' => -> { Config.main_menu.display_options }
    }.freeze

    DISCIPLINES = {
      '1' => -> { puts 'disciplines number 1' },
      '2' => -> { puts 'disciplines number 2' },
      '3' => -> { puts 'disciplines number 3' },
      '4' => -> { Config.main_menu.display_options }
    }.freeze

    ANALYTICS = {
      '1' => -> { puts 'analytics number 1' },
      '2' => -> { puts 'analytics number 2' },
      '3' => -> { puts 'analytics number 3' },
      '4' => -> { Config.main_menu.display_options }
    }.freeze

    EXPORT = {
      '1' => -> { puts 'export number 1' },
      '2' => -> { Config.main_menu.display_options }
    }.freeze

    MAIN = {
      '1' => -> { Config.semesters_menu.display_options },
      '2' => -> { Config.labs_menu.display_options },
      '3' => -> { Config.disciplines_menu.display_options },
      '4' => -> { Config.analytics_menu.display_options },
      '5' => -> { Config.export_menu.display_options }
    }.freeze
  end
end

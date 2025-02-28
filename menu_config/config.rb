# frozen_string_literal: true

require_relative '../menu'
require_relative 'options'
require_relative 'matches'

module MenuConfig
  # Displaying menu options
  module Config
    MENU_PRESETS = {
      main: { options: Options::MAIN, matches: Matches::MAIN },
      semesters: { options: Options::SEMESTERS, matches: Matches::SEMESTERS },
      labs: { options: Options::LABS, matches: Matches::LABS },
      disciplines: { options: Options::DISCIPLINES, matches: Matches::DISCIPLINES },
      analytics: { options: Options::ANALYTICS, matches: Matches::ANALYTICS },
      analytics_specific: { options: Options::ANALYTICS_DETAILS, matches: Matches::ANALYTICS_SPECIFIC },
      analytics_active: { options: Options::ANALYTICS_DETAILS, matches: Matches::ANALYTICS_ACTIVE },
      analytics_completed: { options: Options::ANALYTICS_DETAILS_COMPLETED, matches: Matches::ANALYTICS_COMPLETED },
      export: { options: Options::EXPORT, matches: Matches::EXPORT }
    }.freeze

    def self.display_menu(menu_type)
      @menus ||= {}
      @menus[menu_type] ||= Menu.new(options: MENU_PRESETS[menu_type][:options],
                                     matches: MENU_PRESETS[menu_type][:matches])

      @menus[menu_type].display_options
    end
  end
end

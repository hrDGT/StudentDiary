# frozen_string_literal: true

require_relative '../menu'
require_relative 'options'
require_relative 'matches'

module MenuConfig
  # Creating instances for each menu section
  module Config
    def self.main_menu
      @main_menu ||= Menu.new(options: Options::MAIN, matches: Matches::MAIN)
    end

    def self.semesters_menu
      @semesters_menu ||= Menu.new(options: Options::SEMESTERS, matches: Matches::SEMESTERS)
    end

    def self.labs_menu
      @labs_menu ||= Menu.new(options: Options::LABS, matches: Matches::LABS)
    end

    def self.disciplines_menu
      @disciplines_menu ||= Menu.new(options: Options::DISCIPLINES, matches: Matches::DISCIPLINES)
    end

    def self.analytics_menu
      @analytics_menu ||= Menu.new(options: Options::ANALYTICS, matches: Matches::ANALYTICS)
    end

    def self.export_menu
      @export_menu ||= Menu.new(options: Options::EXPORT, matches: Matches::EXPORT)
    end
  end
end

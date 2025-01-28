# frozen_string_literal: true

require_relative 'menus/menu_module'
require_relative 'menus/submenu'
require_relative 'menus/mainmenu'

require_relative 'semesters'
require_relative 'labs'
require_relative 'disciplines'
require_relative 'analytics'
require_relative 'export'

semesters_menu = SubMenu.new(SEMESTERS_OPTIONS, SEMESTERS_OPTIONS_MATCH)
labs_menu = SubMenu.new(LABS_OPTIONS, LABS_OPTIONS_MATCH)
disciplines_menu = SubMenu.new(DISCIPLINES_OPTIONS, DISCIPLINES_OPTIONS_MATCH)
analytics_menu = SubMenu.new(ANALYTICS_OPTIONS, ANALYTICS_OPTIONS_MATCH)
export_menu = SubMenu.new(EXPORT_OPTIONS, EXPORT_OPTIONS_MATCH)

MAIN_OPTIONS = {
  1 => 'Семестры',
  2 => 'Лабы',
  3 => 'Дисциплины',
  4 => 'Аналитика',
  5 => 'Экспорт'
}.freeze

MAIN_OPTIONS_MATCH = {
  1 => semesters_menu,
  2 => labs_menu,
  3 => disciplines_menu,
  4 => analytics_menu,
  5 => export_menu
}.freeze

main_menu = MainMenu.new(MAIN_OPTIONS, MAIN_OPTIONS_MATCH)

main_menu.display_options

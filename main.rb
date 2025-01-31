# frozen_string_literal: true

require_relative 'menu_config/config'

puts "[Student Diary]\n[Введите exit для выхода]"

MenuConfig::Config.main_menu.display_options

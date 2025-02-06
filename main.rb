# frozen_string_literal: true

require 'dotenv/load'
require_relative 'menu_config/config'
require_relative 'database/database'

puts "[Student Diary]\n[Введите exit для выхода]"

Database::Database.setup

MenuConfig::Config.display_menu(:main)

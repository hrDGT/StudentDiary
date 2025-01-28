# frozen_string_literal: true

some_method = proc { puts 'Future functionality' }

LABS_OPTIONS = {
  1 => 'Управление лабами',
  2 => 'Просмотр лаб',
  3 => 'Вернуться'
}.freeze

LABS_OPTIONS_MATCH = {
  1 => some_method,
  2 => some_method
}.freeze

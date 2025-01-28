# frozen_string_literal: true

some_method = proc { puts 'Future functionality' }

DISCIPLINES_OPTIONS = {
  1 => 'Управление дисциплинами',
  2 => 'Просмотр дисциплинами',
  3 => 'Вернуться'
}.freeze

DISCIPLINES_OPTIONS_MATCH = {
  1 => some_method,
  2 => some_method
}.freeze

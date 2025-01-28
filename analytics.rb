# frozen_string_literal: true

some_method = proc { puts 'Future functionality' }

ANALYTICS_OPTIONS = {
  1 => 'Аналитика по семестру',
  2 => 'Аналитика по активным семстрам',
  3 => 'Аналитика по всем семстрам',
  4 => 'Вернуться'
}.freeze

ANALYTICS_OPTIONS_MATCH = {
  1 => some_method,
  2 => some_method,
  3 => some_method
}.freeze

# frozen_string_literal: true

some_method = proc { puts 'Future functionality' }

EXPORT_OPTIONS = {
  1 => 'Экспортировать в CSV',
  2 => 'Вернуться'
}.freeze

EXPORT_OPTIONS_MATCH = {
  1 => some_method
}.freeze

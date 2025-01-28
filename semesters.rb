# frozen_string_literal: true

some_method = proc { puts 'Future functionality' }

SEMESTERS_OPTIONS = {
  1 => 'Управление семестрами',
  2 => 'Просмотр семестров',
  3 => 'Вернуться'
}.freeze

SEMESTERS_OPTIONS_MATCH = {
  1 => some_method,
  2 => some_method
}.freeze

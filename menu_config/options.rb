# frozen_string_literal: true

module MenuConfig
  module Options
    MAIN = {
      '1' => 'Семестры',
      '2' => 'Дисциплины',
      '3' => 'Лабы',
      '4' => 'Аналитика',
      '5' => 'Экспорт'
    }.freeze

    SEMESTERS = {
      '1' => 'Показать список всех семестров',
      '2' => 'Добавить семестр',
      '3' => 'Изменить семестр',
      '4' => 'Удалить семестр',
      '5' => 'Вернуться'
    }.freeze

    DISCIPLINES = {
      '1' => 'Показать список всех дисциплин',
      '2' => 'Добавить дисциплину',
      '3' => 'Изменить дисциплину',
      '4' => 'Удалить дисциплину',
      '5' => 'Вернуться'
    }.freeze

    LABS = {
      '1' => 'Показать список всех лаб',
      '2' => 'Добавить лабу',
      '3' => 'Изменить лабу',
      '4' => 'Удалить лабу',
      '5' => 'Вернуться'
    }.freeze

    ANALYTICS = {
      '1' => 'Аналитика по выбранному семестру',
      '2' => 'Аналитика по активным семетрам',
      '3' => 'Аналитика по завершенным семестрам',
      '4' => 'Вернуться'
    }.freeze

    ANALYTICS_DETAILS = {
      '1' => 'Только средний балл',
      '2' => 'Невыполненные лабы',
      '3' => 'Просроченные лабы',
      '4' => 'Полный отчет',
      '5' => 'Вернуться'
    }.freeze

    ANALYTICS_DETAILS_COMPLETED = {
      '1' => 'Только средний балл',
      '2' => 'Полный отчет',
      '3' => 'Вернуться'
    }.freeze

    EXPORT = {
      '1' => 'Экспорт данных в CSV',
      '2' => 'Вернуться'
    }.freeze
  end
end

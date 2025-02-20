# frozen_string_literal: true

module Queries
  # Disiplines-related queries
  class DisciplinesQuery
    def display_list
      Database::Database.instance.execute_query(
        query: <<-SQL
          SELECT
            disciplines.id, CONCAT(disciplines.name, ' — ', semesters.id), semesters.name
          FROM
            disciplines JOIN semesters ON disciplines.semester_id = semesters.id
        SQL
      ).each { |row| puts row.values.join(' ') }
    end

    def self.grades_by_id(id:)
      Database::Database.instance.execute_query(query: 'SELECT grade FROM labs WHERE discipline_id = $1',
                                                values: [id]).values.flatten
    end

    def self.lab_ids_by_id(id:)
      Database::Database.instance.execute_query(query: 'SELECT id FROM labs WHERE discipline_id = $1',
                                                values: [id]).values.flatten
    end
  end
end

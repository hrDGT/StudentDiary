# frozen_string_literal: true

# Discipline model class
class Discipline
  attr_accessor :name

  def initialize(id:)
    @id = id
    load_data
  end

  private

  def load_data
    result = Database::Database.instance.execute_query(
      query: 'SELECT name FROM disciplines WHERE id = $1',
      values: [@id]
    )
    @name = result[0].values_at('name')
  end
end

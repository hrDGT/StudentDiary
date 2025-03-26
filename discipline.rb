# frozen_string_literal: true

# Discipline model class
class Discipline
  attr_accessor :name

  def initialize(id:)
    @id = id
    @model = load_data
  end

  def exists?
    @model
  end

  private

  def load_data
    return nil if @id.nil? || !@id.match?(/^\d+$/)

    result = Database::Database.instance.execute_query(
      query: 'SELECT name FROM disciplines WHERE id = $1',
      values: [@id]
    )
    return nil if result.values.empty?

    @name = result[0].values_at('name')

    result
  end
end

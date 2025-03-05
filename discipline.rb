# frozen_string_literal: true

# Discipline model class
class Discipline
  attr_accessor :name

  def initialize(id:)
    @id = id
    load_data
  end

  def exists?
    return false unless @id.match?(/^\d+$/)

    Database::Database.instance.execute_query(query: 'SELECT * FROM disciplines WHERE id = $1',
                                              values: [@id]).ntuples.positive?
  end

  private

  def load_data
    return nil unless @id.match?(/^\d+$/)

    result = Database::Database.instance.execute_query(
      query: 'SELECT name FROM disciplines WHERE id = $1',
      values: [@id]
    )
    return nil if result.values.empty?

    @name = result[0].values_at('name')
  end
end

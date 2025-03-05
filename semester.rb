# frozen_string_literal: true

# Semester model class
class Semester
  attr_accessor :name, :status

  def initialize(id:)
    @id = id
    load_data
  end

  def exists?
    return false unless @id.match?(/^\d+$/)

    Database::Database.instance.execute_query(query: 'SELECT * FROM semesters WHERE id = $1',
                                              values: [@id]).ntuples.positive?
  end

  private

  def load_data
    return nil unless @id.match?(/^\d+$/)

    result = Database::Database.instance.execute_query(
      query: 'SELECT name, end_date, current_date FROM semesters WHERE id = $1',
      values: [@id]
    )
    return nil if result.values.empty?

    @name, end_date, current_date = result[0].values_at('name', 'end_date', 'current_date')
    @status = current_date < end_date ? 'Active' : 'Completed'
  end
end

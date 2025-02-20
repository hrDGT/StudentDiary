# frozen_string_literal: true

# Semester model class
class Semester
  attr_accessor :name, :status

  def initialize(id:)
    @id = id
    load_data
  end

  def exists?
    Database::Database.instance.execute_query(query: 'SELECT * FROM semesters WHERE id = $1',
                                              values: [@id]).ntuples.positive?
  end

  private

  def load_data
    result = Database::Database.instance.execute_query(
      query: 'SELECT name, end_date, current_date FROM semesters WHERE id = $1',
      values: [@id]
    )
    @name, end_date, current_date = result[0].values_at('name', 'end_date', 'current_date')
    @status = current_date < end_date ? 'Active' : 'Completed'
  end
end

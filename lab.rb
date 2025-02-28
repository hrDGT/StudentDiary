# frozen_string_literal: true

# Lab model class
class Lab
  attr_accessor :name, :deadline, :status, :grade

  def initialize(id:)
    @id = id
    load_data
  end

  def active?
    current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)
    deadline = Database::Database.instance.execute_query(
      query: 'SELECT deadline FROM labs WHERE id = $1', values: [@id]
    ).getvalue(0, 0)
    current_date < deadline
  end

  private

  def load_data
    result = Database::Database.instance.execute_query(
      query: 'SELECT name, deadline, status, grade FROM labs WHERE id = $1',
      values: [@id]
    )
    @name, @deadline, @status, @grade = result[0].values_at('name', 'deadline', 'status', 'grade')
  end
end

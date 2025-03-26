# frozen_string_literal: true

# Lab model class
class Lab
  attr_accessor :name, :deadline, :status, :grade

  def initialize(id:)
    @id = id
    @model = load_data
  end

  def exists?
    @model
  end

  def active?
    return false unless @id.match?(/^\d+$/)

    current_date = Database::Database.instance.execute_query(query: 'SELECT CURRENT_DATE').getvalue(0, 0)

    current_date < @deadline
  end

  private

  def load_data
    return nil if @id.nil? || !@id.match?(/^\d+$/)

    result = Database::Database.instance.execute_query(
      query: 'SELECT name, deadline, status, grade FROM labs WHERE id = $1',
      values: [@id]
    )
    return nil if result.values.empty?

    @name, @deadline, @status, @grade = result[0].values_at('name', 'deadline', 'status', 'grade')

    result
  end
end

require_relative('../db/sql_runner')

class Budget

attr_accessor :amount
attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id']
    @amount = options['amount'].to_f
  end

  def save()
    sql = "INSERT INTO budgets (amount) VALUES ($1) RETURNING id"
    values = [@amount]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_f
  end

  def delete()
    sql = "DELETE FROM budgets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.check_budget
    remaining = Budget.remaining_budget
    if remaining > 50.0
      return "green"
    elsif remaining > 0.0
      return "orange"
    else
      return "red"
    end
  end

  def self.edit()
    sql = "UPDATE budgets SET amount = $1 WHERE id = ($2)"
    values = [@amount, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM budgets"
    results = SqlRunner.run(sql)
    return results.map{|budget| Budget.new(budget)}
  end

  def self.total()
    budget_data = Budget.all
    budget_amounts = budget_data.map {|result| result.amount}
    total = budget_amounts.reduce(0) {|sum, amount| sum + amount}
    return total
  end

  def self.remaining_budget
    remaining_budget = Budget.total - Transaction.total
    return remaining_budget
  end

  def self.remaining_monthly_budget
    remaining_budget = Budget.total - Transaction.current_month_total
    return remaining_budget
  end

  def self.past_remaining_monthly_budget(month_number)
    remaining_budget = Budget.total - Transaction.month_total(month_number)
    return remaining_budget
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run(sql)
  end

end

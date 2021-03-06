require_relative('../db/sql_runner')

class Merchant

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def edit()
    sql = "UPDATE merchants SET name = $1 WHERE id = ($2)"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def frequency()
    sql = "SELECT transactions.merchant_id FROM transactions WHERE merchant_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|merchant|}.length
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    return results.map{|merchant| Merchant.new(merchant)}
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values).first
    return Merchant.new(results)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.find_by_name(name)
   sql = "SELECT * FROM merchants WHERE LOWER(name) = $1"
   values = [name.downcase]
   results = SqlRunner.run(sql, values).first
    if results == nil
      return nil
    else
      found_merchant = Merchant.new(results)
      return found_merchant
    end
 end


end

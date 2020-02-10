require_relative('../db/sql_runner')

class Transaction

    attr_accessor :amount, :merchant_id
    attr_reader :id, :time_inserted

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @merchant_id = options['merchant_id'].to_i

      if options['time_inserted']
        @time_inserted = options['time_inserted']
      else @time_inserted = DateTime.now
      end
      
  end


  def save()
    sql = "INSERT INTO transactions (amount, merchant_id, time_inserted) VALUES ($1, $2, $3) RETURNING id"
    values = [@amount, @merchant_id, @time_inserted]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def edit()
    sql = "UPDATE transactions SET (amount, merchant_id) = ($1, $2) WHERE id = ($3)"
    values = [@amount, @merchant_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def merchant_name()
    sql = "SELECT merchants.name FROM merchants WHERE id = $1"
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values).first
    return merchant["name"]
  end

  def tag_names()
    sql = "SELECT tags.name FROM tags INNER JOIN transactions_tags ON tags.id = tag_id WHERE transaction_id = $1"
    values = [@id]
    tags = SqlRunner.run(sql, values)
    tag_names = tags.map {|tag| tag["name"].downcase}
    return tag_names.join(", ")
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.total()
    all_transactions = Transaction.all
    amounts = all_transactions.map {|result| result.amount}
    total = amounts.reduce(0) {|sum, amount| sum + amount}
    return total
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end


end

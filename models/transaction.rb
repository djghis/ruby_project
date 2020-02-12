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
      else @time_inserted = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
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

  def tags()
    sql = "SELECT tags.id FROM tags INNER JOIN transactions_tags ON tags.id = tag_id WHERE transaction_id = $1"
    values = [@id]
    tags = SqlRunner.run(sql, values)
    tag_ids = tags.map {|tag| tag['id'].to_i}
    return tag_ids
  end


  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    transactions = results.map{|transaction| Transaction.new(transaction)}
    return transactions.sort_by{|transaction| transaction.time_inserted}.reverse
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values).first
      if results == nil
        return nil
      else
        found_transaction = Transaction.new(results)
        return found_transaction
      end
  end

  def self.get_merchant_id(merchant_name)
    sql = "SELECT merchants.id FROM merchants WHERE LOWER(name) = $1"
    values = [merchant_name.downcase]
    results = SqlRunner.run(sql, values).first
      if results == [""] || results == nil
        return nil
      else
        return results['id'].to_i
      end
  end

  def self.find_by_merchant(merchant_name)
    merchant_id = Transaction.get_merchant_id(merchant_name)
    sql = "SELECT * FROM transactions WHERE merchant_id = $1"
    values = [merchant_id]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.get_tag_id(tag_name)
    sql = "SELECT tags.id FROM tags WHERE LOWER(name) = $1"
    values = [tag_name.downcase]
    if values == [""]
      return nil
    else
      result = SqlRunner.run(sql, values).first
      if result != nil
        return result['id'].to_i
      else
        return nil
      end
    end
  end

  def self.find_by_tag(tag_name)
    tag_id = Transaction.get_tag_id(tag_name.to_s)
    sql = "SELECT transactions.* FROM transactions INNER JOIN transactions_tags ON transactions.id = transaction_id WHERE tag_id = $1"
    values = [tag_id]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_by_amount_more_than(amount)
    sql = "SELECT * FROM transactions WHERE amount > $1"
    values = [amount]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_by_amount_less_than(amount)
    sql = "SELECT * FROM transactions WHERE amount < $1"
    values = [amount]
    results = SqlRunner.run(sql, values)
    return results.map{|transaction| Transaction.new(transaction)}
  end

  def self.sort_by_time()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    results_array = results.map{|transaction| Transaction.new(transaction)}
    return results_array.sort_by{|transaction| transaction.time_inserted}
  end

  def self.find_all(search_term)
    merchants = Transaction.find_by_merchant(search_term.to_s)
    tags = Transaction.find_by_tag(search_term.to_s)

      if merchants == nil && tags == nil
        return nil
      elsif merchants == nil && tags != nil
        return tags
      elsif tags == nil && merchants != nil
        return merchants
      else
        return merchants + tags
      end
  end

  def self.total()
    all_transactions = Transaction.all
    amounts = all_transactions.map {|result| result.amount}
    total = amounts.reduce(0) {|sum, amount| sum + amount}
    return total
  end

  def self.find_by_month(month_number)
    sql = "SELECT * FROM transactions WHERE extract(month FROM time_inserted) = $1"
    values = [month_number]
    results = SqlRunner.run(sql, values)
    return results.map {|transaction| Transaction.new(transaction)}
  end

  def self.find_by_current_month
    sql = "SELECT * FROM transactions WHERE extract(month FROM time_inserted) = extract(month FROM CURRENT_DATE)"
    results = SqlRunner.run(sql)
    return results.map {|transaction| Transaction.new(transaction)}
  end

  def self.month_total(month_number)
    months_transactions = Transaction.find_by_month(month_number)
    amounts = months_transactions.map {|result| result.amount}
    total = amounts.reduce(0) {|sum, amount| sum + amount}
    return total
  end

  def self.current_month_total
    months_transactions = Transaction.find_by_current_month
    amounts = months_transactions.map {|result| result.amount}
    total = amounts.reduce(0) {|sum, amount| sum + amount}
    return total
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end


end

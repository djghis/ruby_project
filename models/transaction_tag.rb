require_relative('../db/sql_runner')

class TransactionTag

  attr_reader :id, :transaction_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @transaction_id = options['transaction_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions_tags (transaction_id, tag_id) VALUES ($1, $2) RETURNING id"
    values = [@transaction_id, @tag_id]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def edit()
    sql = "UPDATE transactions_tags SET (transaction_id, tag_id) = ($1, $2) WHERE id = ($3)"
    values = [@transaction_id, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions_tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM transactions_tags"
    results = SqlRunner.run(sql)
    return results.map{|transaction_tag| TransactionTag.new(transaction_tag)}
  end

  def self.delete_all()
    sql = "DELETE FROM transactions_tags"
    SqlRunner.run(sql)
  end

end

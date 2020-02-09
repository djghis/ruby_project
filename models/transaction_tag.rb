require_relative('../db/sql_runner')

class TransactionTag

  attr_reader :id, :transaction_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @transaction_id = options['transaction_id']
    @tag_id = options['tag_id']
  end


  def save()
    sql = "INSERT INTO transactions_tags (transaction_id, tag_id) VALUES ($1, $2) RETURNING id"
    values = [@transaction_id, @tag_id]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

end

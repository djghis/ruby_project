require_relative('../db/sql_runner')

class Transaction

    attr_reader :id, :amount, :merchant_id, :tag_id, :time_inserted

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_f
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
    @time_inserted = DateTime.now
  end

  def save()
    sql = "INSERT INTO transactions (amount, merchant_id, tag_id, time_inserted) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@amount, @merchant_id, @tag_id, @time_inserted]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

end

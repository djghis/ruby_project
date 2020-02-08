require('pg')

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({dbname: 'money_tracker', host: 'localhost'})
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
      db.prepare("time", "INSERT INTO transactions (amount, merchant_id, tag_id, time_inserted) VALUES ($1, $2, $3, $4) RETURNING id");
      update = Time.now.strftime("%Y-%m-%d %H:%M:%S");
      db.exec_prepared("time", [amount, merchant_id, tag_id, time_inserted]);
    ensure
      db.close() if db != nil
    end
    return result
  end

end


# 
# db.prepare('statement1', "INSERT INTO games (game_hash,team1,team2,team1score,team2score,time,update_at) VALUES ($1,$2,$3,$4,$5,$6,$7)");
# update = Time.now.strftime("%Y-%m-%d %H:%M:%S");
# db.exec_prepared('statement1', [myId, team1, team1score, team2, team2score, progress, update]);

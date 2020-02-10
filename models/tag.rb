require_relative('../db/sql_runner')

class Tag

    attr_accessor :name
    attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def edit()
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def frequency()
    sql = "SELECT transactions_tags.tag_id FROM transactions_tags WHERE tag_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|tag|}.length
  end

  def self.all()
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    return results.map{|tag| Tag.new(tag)}
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values ).first
    return Tag.new(results)
  end

  def self.find_by_name(name)
   sql = "SELECT * FROM tags WHERE LOWER(name) = $1"
   values = [name.downcase]
   results = SqlRunner.run(sql, values).first
    if results == nil
      return nil
    else
      found_tag = Tag.new(results)
      return found_tag
    end
 end


end

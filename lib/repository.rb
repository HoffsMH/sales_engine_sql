require_relative 'file_io'
require_relative 'modules/find_by'
require_relative 'modules/find_all_by'
require 'bigdecimal'

class Repository
  attr_reader :se, :table, :quick_lookup_table, :db
  
  def initialize(sales_engine, records, db)
    @se = sales_engine
    @table = []
    @db = db
    load_data(records)
    
  end
  
  include FindBy
  include FindAllBy
  
  def all
    result = db.execute("select * from #{self.table_name}")
  end
  
  def random
    db.execute("select * from #{self.table_name} order by random() limit 1")
  end
  
  def find_by(symbol, hunt)
    result = db.execute("select  * from #{self.table_name} where #{symbol.to_s} = \'#{hunt}\' LIMIT 1")
    result[0]
    self.child_class.new(result[0], self)
  end
  
  def find_all_by(symbol, hunt)
    result = db.execute("select  * from #{self.table_name} where #{symbol.to_s} = \'#{hunt.to_s}\'")
    result.map do |record|
      self.child_class.new(record, self)
    end
  end
  
  def find_all_by_date(symbol, date)
    self.table.select do |thing|
      thing.send(symbol)[0..9] == good_date(date)
    end
  end
  
  def good_date(date)
    if date.class == Date
      date.strftime("%Y-%m-%d")
    else
      Date.parse(date).strftime("%Y-%m-%d")
    end
  end
  
  def repo_table(symbol_thing)
    @se.send(symbol_thing).table
  end
  
  def inspect
    self.class
  end
  
end

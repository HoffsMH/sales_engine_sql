require_relative 'modules/find_by'
require_relative 'modules/find_all_by'
require 'bigdecimal'
require 'csv'

class Repository
  attr_reader :se, :table, :quick_lookup_table, :db
  
  def initialize(sales_engine, records, db)
    @se = sales_engine
    @table = []
    @db = db
    make_table
    fill_table(records)
    
  end
  
  include FindBy
  include FindAllBy
  
  def convert(result)
    result.map do |record|
       self.child_class.new(record, self)
    end
  end
  
  def all
    result = db.execute("select * from #{self.table_name}")
    convert(result)
  end
  
  def random
      result =  db.execute("select * from #{self.table_name} order by random() limit 1")
      convert(result)[0]
  end
  
  def find_by(symbol, hunt)
    result = db.execute("select  * from #{self.table_name} where #{symbol.to_s} = \'#{hunt}\' LIMIT 1")
    result[0]
    self.child_class.new(result[0], self)
  end
  
  def find_all_by(symbol, hunt)
    result = db.execute("select  * from #{self.table_name} where #{symbol.to_s} = \'#{hunt.to_s}\'")
    convert(result)
  end
  
  def good_date(date)
    if date.class == Date
      date.strftime("%Y-%m-%d")
    else
      Date.parse(date).strftime("%Y-%m-%d")
    end
  end
  def fill_table(data)
    args = {:headers => true,
      :header_converters => :symbol,
      :converters => :all}
      
      CSV.parse(data, args) do |row|
        formatted_row =  row.fields
        
        formatted_row[-2] = formatted_row[-2].gsub(" UTC", "")
        formatted_row[-1] = formatted_row[-1].gsub(" UTC", "")
        value_string = []
        row.fields.size.times { value_string << "?"}
        
        db.execute "insert into #{self.table_name} values (#{value_string.join(",")})" , formatted_row
      end
    end
  
  def inspect
    self.class
  end
  
end

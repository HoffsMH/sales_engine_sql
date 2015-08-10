require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  
  attr_accessor :table_name, :child_class

  def load_data(data)
    @table_name = 'customers'
    @child_class = Customer
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name     VARCHAR(31),
      last_name     VARCHAR(31),
      created_at datetime,
      updated_at datetime
    );
    SQL
    
    args = {:headers => true,       
            :header_converters => :symbol,
            :converters => :all}
            
    CSV.parse(data, args) do |row|
      db.execute "insert into customers values ( ?, ?, ?, ?, ?)", row.fields 
    end
    
    
  end

end

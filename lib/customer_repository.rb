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
      created_at date,
      updated_at date
    );
    SQL
    
    args = {:headers => true,       
            :header_converters => :symbol,
            :converters => :all}
            
    CSV.parse(data, args) do |row|
      
      formatted_row =  row.fields
      
      formatted_row[-2] = formatted_row[-2].gsub(" UTC", "")
      formatted_row[-1] = formatted_row[-1].gsub(" UTC", "")
      

      db.execute "insert into customers values (?,?,?,?,?)" , formatted_row
    end
    
    
  end

end

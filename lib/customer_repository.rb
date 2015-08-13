require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  
  attr_accessor :table_name, :child_class
  
  def make_table
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
  end
  end

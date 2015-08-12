require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  attr_accessor :table_name, :child_class
  
  def make_table
    @table_name = 'transactions'
    @child_class = Transaction
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      invoice_id     INTEGER,
      credit_card_number    VARCHAR(31),
      credit_card_expiration_date    VARCHAR(31),
      result    VARCHAR(31),
      created_at date,
      updated_at date
    );
    SQL
  end
end

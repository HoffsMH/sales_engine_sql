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
  # id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at

  def add_transaction(invoice_id, info)
    new_id = table.last.id + 1
    cc_number = info[:credit_card_number]
    cc_exp = info[:credit_card_expiration]
    result = info[:result]
    created_at = Time.now.utc.to_s
    updated_at = created_at

    new_record = [new_id, invoice_id, cc_number, cc_exp,
                  result, created_at, updated_at]
    new_transaction = Transaction.new(new_record, self)
    table.push(new_transaction)
    @quick_lookup_table = populate_quick_lookup_table(table)
    new_transaction
  end

end

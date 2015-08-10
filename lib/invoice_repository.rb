require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository

  attr_accessor :table_name, :child_class
  
  def make_table
    @table_name = 'invoices'
    @child_class = Invoice
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      customer_id     INTEGER,
      merchant_id    INTEGER,
      status    VARCHAR(31),
      created_at date,
      updated_at date
    );
    SQL
  end
  


  def create(invoice_info)
    customer_id = invoice_info[:customer].id
    merchant_id = invoice_info[:merchant].id
    status = invoice_info[:status]
    created_at = Time.now.utc.to_s
    updated_at = created_at
    items = invoice_info[:items]
    new_id = table.last.id + 1

    new_record = [new_id, customer_id, merchant_id,
                  status, created_at, updated_at]
    new_invoice = Invoice.new(new_record, self)
    table.push(new_invoice)
    @quick_lookup_table = populate_quick_lookup_table(table)

    se.invoice_item_repository.add_invoice_items(items, new_id)

    new_invoice
  end

end

require 'pry'
require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository

  attr_accessor :table_name, :child_class
  
  def make_table
    @table_name = 'invoice_items'
    @child_class = InvoiceItem
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      item_id     INTEGER,
      invoice_id    INTEGER,
      quantity    INTEGER,
      unit_price    INTEGER,
      created_at date,
      updated_at date
    );
    SQL
  end

  def add_invoice_items(items, invoice_id)
    items_by_id = items.group_by {|item| item.id}
    item_counts = items_by_id.map{|id, items| [id, items.count]}

    item_counts.map do |item_id, quantity|
      unit_price = se.item_repository.find_by(:id, item_id).unit_price
      created_at = Time.now.utc.to_s
      updated_at = created_at
      new_invoice_item = se.db.execute("insert into invoice_items 
                          (item_id,
                           invoice_id,
                           quantity,
                           unit_price,
                           created_at,
                           updated_at)
                         values
                            (#{item_id},
                              #{invoice_id},
                             '#{quantity}',
                             '#{unit_price}',
                             '#{created_at}',
                             '#{updated_at}')")
      new_id = se.db.execute("select id from invoice_items order by id desc limit 1").flatten.first 
      find_by(:id, new_id)
    end
  end

end

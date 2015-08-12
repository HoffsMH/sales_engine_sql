require_relative 'repository'
require_relative 'item'

class ItemRepository < Repository

  attr_accessor :table_name, :child_class
  
  def make_table
    @table_name = 'items'
    @child_class = Item
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      name    VARCHAR(31),
      description   VARCHAR(31),
      unit_price    INTEGER,
      merchant_id    INTEGER,
      created_at date,
      updated_at date
    );
    SQL
  end
  
  # id,name,description,unit_price,merchant_id,created_at,updated_at

  def most_revenue(item_count)
    items = Hash.new(0)
    item_revenues = db.execute("select 
                  invoice_items.item_id,
                  invoice_items.unit_price, 
                  invoice_items.quantity,
                   transactions.result 
                from invoice_items 
                left join transactions 
                  on invoice_items.invoice_id = transactions.invoice_id 
                where 
                  transactions.result = 'success'")
    
    item_revenues.each do |item_revenue|
      items[item_revenue[0]] += item_revenue[1] * item_revenue[2]
    end
    sorted_items = items.sort_by do |item|
      item[1]
    end.reverse
    top_item_ids = sorted_items[0..item_count-1]
    top_item_ids.map do |top_item_id|
      find_by_id(top_item_id[0])
    end
  end

  def most_items(item_count)
    items = Hash.new(0)
    item_quantities = db.execute("select 
                  invoice_items.item_id,
                  invoice_items.unit_price, 
                  invoice_items.quantity,
                   transactions.result 
                from invoice_items 
                left join transactions 
                  on invoice_items.invoice_id = transactions.invoice_id 
                where 
                  transactions.result = 'success'")
    item_quantities.each do |item_revenue|
      items[item_revenue[0]] += item_revenue[2]
    end
    sorted_items = items.sort_by do |item|
      item[1]
    end.reverse
    
    sorted_items[0..item_count-1].map do |item|
      find_by_id(item[0])
    end
  end

end

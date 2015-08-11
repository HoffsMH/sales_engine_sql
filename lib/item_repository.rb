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

    invoice_items = se.invoice_item_repository
    revenue = invoice_items.item_data_by_invoice(:simple_revenue)
    item_revenue_by_invoice = revenue
    items_by_revenue = invoice_items.items_values(item_revenue_by_invoice)

    items_by_revenue = items_by_revenue.sort_by do |item,revenue|
      revenue
    end

    items_by_revenue.reverse!
    top_items = items_by_revenue[0..item_count-1].map do |item_id, revenue|
      find_by_id(item_id)
    end
    top_items
  end

  def most_items(item_count)
    invoice_items = se.invoice_item_repository
    item_quantity_by_invoice = invoice_items.item_data_by_invoice(:quantity)
    items_by_quantity = invoice_items.items_values(item_quantity_by_invoice)

    items_by_quantity = items_by_quantity.sort_by do |item,quantity|
      quantity
    end
    items_by_quantity.reverse!
    top_items = items_by_quantity[0..item_count-1].map do |item_id, quantity|
      find_by_id(item_id)
    end
  end

end

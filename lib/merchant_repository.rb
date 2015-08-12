require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository

  attr_accessor :table_name, :child_class
  
  def make_table
    @table_name = 'merchants'
    @child_class = Merchant
    
    rows = db.execute <<-SQL
    create table #{@table_name} (
      id       INTEGER PRIMARY KEY AUTOINCREMENT,
      name    VARCHAR(31),
      created_at date,
      updated_at date
    );
    SQL
  end

  def most_revenue(merchant_count)
    merchants_revenue = Hash.new(0)
    price_quantities =  se.db.execute("select
                          invoice_items.unit_price,
                          invoice_items.quantity,
                          invoices.merchant_id
                      from invoice_items
                      join invoices on
                          invoice_items.invoice_id = invoices.id
                      join transactions on
                          transactions.invoice_id = invoices.id
                      where
                          transactions.result = 'success'")
    price_quantities.each do |price_q|
      price = price_q[0]
      quantity = price_q[1]
      merchant_id = price_q[2]
      merchants_revenue[merchant_id] += (price * quantity)
    end
    sorted_merchants = merchants_revenue.sort_by do |merchant|
      merchant[1]
    end.reverse
    
    sorted_merchants[0..merchant_count-1].map do |merchant|
      find_by(:id, merchant[0])
    end
    
    
    
  end

  def most_items(merchant_count)
    merchants = Hash.new(0)
    merchant_quantities = db.execute("select 
                                      invoices.merchant_id, 
                                      invoice_items.quantity  
                                    from invoice_items 
                                    left join invoices on 
                                      invoice_items.invoice_id = invoices.id 
                                    left join transactions on 
                                      transactions.invoice_id =  invoices.id 
                                    where 
                                      transactions.result = 'success'")
    merchant_quantities.map do |merchant_quantity|
      merchant_id = merchant_quantity[0]
      quantity =  merchant_quantity[1]
      merchants[merchant_id] += quantity
    end
    
    sorted_merchants = merchants.sort_by do |merchant|
      merchant[1]
    end.reverse
    sorted_merchants[0..merchant_count-1].map do |merchant|
      find_by_id(merchant[0])
    end
    
      
  end

  def revenue(date)
    date_str = good_date(date)
    prices_quantities = se.db.execute("select 
                                          invoice_items.unit_price, 
                                          invoice_items.quantity
                                      from 
                                          invoice_items 
                                      join invoices 
                                      on 
                                          invoice_items.invoice_id = invoices.id
                                      join transactions 
                                      on 
                                          transactions.invoice_id = invoices.id 
                                      where 
                                          date(invoices.created_at) = '#{date_str}'
                                      and
                                          transactions.result = 'success'")
    total = prices_quantities.reduce(0) do |sum, price_q|
      price = price_q.first
      quantity = price_q.last
      sum + (price * quantity)
    end
    total * 0.01
  end
  def ranked_merchants(merchant_list)
    merchant_list.sort_by{|merchant, quantity| quantity}.reverse
  end

  def top_merchants(count, merchants)
    merchants[0..count - 1].map{|merchant_rank| find_by_id(merchant_rank.first)}
  end

  def revenue_list
    invoice_items = se.invoice_item_repository
    item_revenues = invoice_items.item_data_by_invoice(:simple_revenue)
    data_by_merchant(item_revenues)
  end

  def quantity_sold_list
    invoice_items = se.invoice_item_repository
    item_quantities = invoice_items.item_data_by_invoice(:quantity)
    data_by_merchant(item_quantities)
  end

end

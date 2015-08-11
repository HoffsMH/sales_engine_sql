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
    revenues = all.map do |merchant|
      [merchant.id, merchant.revenue]
    end
    sorted_revenues = revenues.sort_by do |pair|
      pair[1]
    end.reverse
    sorted_revenues[0..merchant_count-1].map do |pair|
      find_by_id(pair[0])
    end
  end

  def most_items(merchant_count)
    top_merchants(merchant_count, ranked_merchants(quantity_sold_list))
  end

  def revenue(date)
    date = good_date(date)
    total = 0

    revenue_by_invoice.each do |invoice_id, revenue|
      invoice = se.invoice_repository.find_by(:id, invoice_id)
      if invoice.successful? && good_date(invoice.created_at) == date
          total += revenue
      end
    end
    total * 0.01
  end

  def revenue_by_invoice
    invoices = Hash.new(0)
    se.invoice_item_repository.all.each do |invoice_item|
      invoice_id = invoice_item.invoice_id
      invoices[invoice_id] += invoice_item.simple_revenue
    end
    invoices
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

  def data_by_merchant(item_data_by_invoice)
    output = Hash.new(0)
    item_data_by_invoice.each do |invoice_id, item_data|
      invoice = se.invoice_repository.find_by_id(invoice_id)
      if invoice.successful?
        item_data.each {|item_id, data| output[invoice.merchant_id] += data}
      end
    end
    output
  end

end

require 'bigdecimal'
class Merchant
  attr_reader :id, :name, :merchant_id, :merchant_repository,
  :created_at, :updated_at, :fields
  
  def initialize(input_data, merchant_repository)
    @id = input_data[0].to_i
    @name = input_data[1]
    @created_at = input_data[2]
    @updated_at = input_data[3]
    @merchant_repository = merchant_repository
    @fields = [:id, :name, :merchant_id,
      :created_at, :updated_at]
    end
    
    def items
      merchant_repository.se.item_repository.find_all_by(:merchant_id, id)
    end
    
    def invoices
      merchant_repository.se.invoice_repository.find_all_by(:merchant_id, id)
    end
    def revenue(date = false)
      if date
        revenue_with_date(date)
      else
        revenue_total
      end
    end
    def revenue_total
      total = prices_and_quantities.reduce(0) do |sum, price_and_quantity|
        price = price_and_quantity[0]
        quantity = price_and_quantity[1]
        sum + (price * quantity)
      end
      total * 0.01
    end
    def prices_and_quantities
      merchant_repository.db.execute("select 
      invoice_items.unit_price, 
      invoice_items.quantity,
      invoices.created_at
      from 
      invoice_items 
      left join transactions 
      on invoice_items.invoice_id = transactions.invoice_id 
      left join invoices 
      on invoices.id = invoice_items.invoice_id 
      where 
      transactions.result = 'success' 
      and 
      invoices.merchant_id = #{id}")
    end
    def revenue_with_date(date)
      # db.execute("select invoice_items.unit_price, invoice_items.quantity from invoice_items left join transactions on invoice_items.invoice_id = transactions.invoice_id left join invoices on invoices.id = invoice_items.invoice_id where transactions.result = 'success' and invoices.merchant_id = 26 and date(invoices.created_at) = #{merchant_repository.good_date(date)}")
      total = prices_and_quantities.reduce(0) do |sum, price_and_quantity|
        if merchant_repository.good_date(price_and_quantity[2]) ==  merchant_repository.good_date(date)
          price = price_and_quantity[0]
          quantity = price_and_quantity[1]
          sum + (price * quantity)
        else
          sum + 0
        end
      end
      BigDecimal.new(total) * 0.01
    end
    
    def favorite_customer
      customer_ids = merchant_repository.db.execute("select 
      invoices.customer_id
      from invoices
      inner join transactions 
      on invoices.id = transactions.invoice_id
      where 
      transactions.result = 'success' 
      and 
      invoices.merchant_id = #{id}")
      
      grouped_customer_ids = customer_ids.group_by do |customer_id|
        customer_id
      end
      
      counts = grouped_customer_ids.map do |grouped|
        [grouped[0][0], grouped[1].size]
      end
      sorted_counts = counts.sort_by do |count|
        count[1]
      end.reverse
      
      merchant_repository.se.customer_repository.find_by_id(sorted_counts[0][0])
    end
    
    def customers_with_pending_invoices
      pending_invoices = invoices.select do |invoice|
        !invoice.successful?
      end
      pending_invoices
      
      customer_ids = pending_invoices.map do |invoice|
        invoice.customer_id
      end
      customer_ids.map do |customer_id|
        merchant_repository.se.customer_repository.find_by_id(customer_id)
      end
    end
    
    def inspect
      self.class.to_s
    end
    
  end

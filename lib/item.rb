class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
  :updated_at, :item_repository, :fields
  
  def initialize(input_data, item_repository)
    @id = input_data[0].to_i
    @name = input_data[1]
    @description = input_data[2]
    @unit_price = BigDecimal.new(input_data[3])
    @merchant_id = input_data[4].to_i
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @item_repository = item_repository
    @fields = [:id, :name, :description, :unit_price, :merchant_id, :created_at,
      :updated_at]
  end
    
    def invoice_items
      item_repository.se.invoice_item_repository.find_all_by_item_id(id)
    end
    
    def merchant
      item_repository.se.merchant_repository.find_by(:id, merchant_id)
    end
    
    def best_day
      day_ranks = Hash.new(0)
      info = item_repository.se.db.execute("select 
      invoice_items.quantity,
      invoices.created_at
      from invoice_items
      join invoices
      on invoices.id = invoice_items.invoice_id
      join transactions
      on invoice_items.invoice_id = transactions.invoice_id
      where
      transactions.result = 'success'
      and
      invoice_items.item_id = #{id}")
      info.each do |quantity, date|
        day_ranks[item_repository.good_date(date)] += quantity
      end
      sorted_day_ranks = day_ranks.sort_by do |key, value|
        value
      end.reverse
      if sorted_day_ranks.nil? ||sorted_day_ranks[0].nil?
        nil
      else
        Date.parse(sorted_day_ranks[0][0])
      end
    end
  end

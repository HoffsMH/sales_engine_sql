class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at,
              :invoice_repository, :fields

  def initialize(input_data, invoice_repository)
    @id = input_data[0].to_i
    @customer_id = input_data[1].to_i
    @merchant_id = input_data[2].to_i
    @status = input_data[3]
    @created_at = input_data[4]
    @updated_at = input_data[5]
    @invoice_repository = invoice_repository
    @fields = [:id, :customer_id, :merchant_id,
                :status, :created_at, :updated_at]
  end

  def transactions
    result = invoice_repository.db.execute("select *  from transactions where invoice_id = #{id}")
    invoice_repository.se.transaction_repository.convert(result)
  end


  def invoice_items
    result = invoice_repository.db.execute("select *  from invoice_items where invoice_id = #{id}")
    invoice_repository.se.invoice_item_repository.convert(result)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_repository.se.item_repository.find_by(:id, invoice_item.item_id)
    end.uniq
  end

  def customer
    invoice_repository.se.customer_repository.find_by(:id, customer_id)
  end

  def merchant
    invoice_repository.se.merchant_repository.find_by(:id, merchant_id)
  end

  def revenue
    total_revenue = 0
    query = "select
                invoice_items.unit_price,
                invoice_items.quantity
              from invoice_items 
                join transactions on
                  invoice_items.invoice_id = transactions.invoice_id
              where 
                invoice_items.invoice_id = #{id}
              and
                transactions.result = 'success'"
    result = invoice_repository.db.execute(query)

    result.reduce(0) do |sum, price, quantity|
      sum + (price * quantity)
    end
  end

  def successful?
    query = "select
              *
            from 
              transactions
            join invoices on
              transactions.invoice_id = invoices.id
            where
              transactions.invoice_id = #{id}
            and
              transactions.result = 'success'"
    result = invoice_repository.db.execute(query)
    return true if result.size > 0 else false
  end

  def charge(info)
    invoice_id = id
    credit_card_number = info[:credit_card_number]
    credit_card_expiration_date = info[:credit_card_expiration_date]
    result = info[:result]
    created_at = Time.now.utc.to_s
    updated_at = created_at

    new_transaction = invoice_repository.se.db.execute("insert into transactions 
                        (invoice_id,
                         credit_card_number,
                         credit_card_expiration_date,
                         result,
                         created_at,
                         updated_at)
                       values
                          (#{invoice_id},
                            #{credit_card_number},
                           '#{credit_card_expiration_date}',
                           '#{result}',
                           '#{created_at}',
                           '#{updated_at}')")
    new_id = invoice_repository.se.db.execute("select id from transactions order by id desc limit 1").flatten.first
    invoice_repository.se.transaction_repository.find_by_id(new_id)
  end

end

class Customer
  attr_reader :id, :first_name, :last_name,
  :created_at, :updated_at, :customer_repository, :fields

  def initialize(input_data, customer_repository)
    @id = input_data[0].to_i
    @first_name = input_data[1]
    @last_name = input_data[2]
    @created_at = input_data[3]
    @updated_at = input_data[4]
    @customer_repository = customer_repository
    @fields = [:id, :first_name, :last_name,
      :created_at, :updated_at]
  end

  def invoices
    result = @customer_repository.db.execute("select * from invoices where customer_id = #{id}")
    @customer_repository.se.invoice_repository.convert(result)
  end


  def transactions
    query = "select 
                * 
            from transactions 
            join invoices on
              transactions.invoice_id = invoices.id
             where invoices.customer_id = #{id}"
    result = @customer_repository.db.execute(query)
    customer_repository.se.transaction_repository.convert(result)
  end
    def favorite_merchant
      merchants = Hash.new(0)
      query = "select
                  invoices.merchant_id
              from invoices
              join transactions on
                transactions.invoice_id = invoices.id
              where
                transactions.result = 'success'
              and
                invoices.customer_id = #{id}"
      info = customer_repository.db.execute(query)
      info.each do |merchant_id|
        merchants[merchant_id] += 1
      end
      sorted_merchants = merchants.sort_by do |merchant_id, quantity|
        quantity
      end.reverse
      
      merchant_id = sorted_merchants.first.first.first
      customer_repository.se.merchant_repository.find_by(:id, merchant_id)
    end

  end

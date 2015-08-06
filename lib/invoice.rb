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
    transaction_repository = invoice_repository.se.transaction_repository
    transaction_repository.table.select do |transaction|
      transaction.invoice_id == id
    end
  end

  def invoice_items
    invoice_item_repository = invoice_repository.se.invoice_item_repository
    invoice_item_repository.find_all_by_invoice_id(id)
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
    invoice_repository.se.merchant_repo.find_by(:id, merchant_id)
  end

  def revenue
    invoice_item_repository = invoice_repository.se.invoice_item_repository
    invoice_items = invoice_item_repository.find_all_by(:invoice_id, id)

    invoice_items.reduce(0) {|sum, invoice_item| sum + invoice_item.revenue}
  end

  def successful?
    transaction_repository = invoice_repository.se.transaction_repository
    transaction = transaction_repository.find_by(:invoice_id, id)

    if transaction.nil?
      false
    elsif transaction.successful?
      true
    elsif !transaction.nil?
      transactions = transaction_repository.all
      next_index = transactions.index(transaction) + 1
      transaction_repository.all[next_index..-1].any? do |transaction|
        transaction.invoice_id == id && transaction.successful?
      end
    end

  end

  def charge(info)
    invoice_repository.se.transaction_repository.add_transaction(id, info)
  end

end

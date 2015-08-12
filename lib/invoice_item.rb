class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
  :unit_price, :created_at, :updated_at,
  :invoice_item_repository, :fields

  def initialize(input_data, invoice_item_repository)
    @id = input_data[0].to_i
    @item_id = input_data[1].to_i
    @invoice_id = input_data[2].to_i
    @quantity = input_data[3].to_i
    @unit_price = BigDecimal.new(input_data[4])
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @invoice_item_repository = invoice_item_repository
    @fields = [:id, :item_id, :invoice_id, :quantity,
    :unit_price, :created_at, :updated_at]
  end

  def invoice
    invoice_item_repository.se.invoice_repository.find_by(:id, invoice_id)
  end

  def item
    invoice_item_repository.se.item_repository.find_by(:id, item_id)
  end

  def revenue
    if successful? then BigDecimal.new(quantity) * unit_price else 0 end
  end

  def simple_revenue
    quantity * unit_price
  end

  def merchant
    merchant_id = invoice.merchant_id
    invoice_item_repository.se.merchant_repository.find_by(:id, merchant_id)
  end

  def successful?
    invoice_repository = invoice_item_repository.se.invoice_repository
    invoice = invoice_repository.find_by(:id, invoice_id)

    invoice && invoice.successful?
  end

end

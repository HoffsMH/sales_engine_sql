class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date,
  :result, :created_at, :updated_at,
  :transaction_repository, :fields

  def initialize(input_data, transaction_repository)
    @id = input_data[0].to_i
    @invoice_id = input_data[1].to_i
    @credit_card_number = input_data[2]
    @credit_card_expiration_date = input_data[3]
    @result = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[5]
    @transaction_repository = transaction_repository
    @fields = [:id, :invoice_id, :credit_card_number,
    :credit_card_expiration_date,
    :result, :created_at, :updated_at]
  end

  def invoice
    transaction_repository.se.invoice_repository.find_by(:id, invoice_id)
  end
  def successful?
    result == "success"
  end
end

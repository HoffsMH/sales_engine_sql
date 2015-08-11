require_relative 'test_helper'


class TransactionRepositoryTest < MiniTest::Test
  def se_with_transactions(transactions)
    engine = SalesEngine.new
    engine.db_startup
    engine.transaction_repo_startup(transactions)
    engine
  end
  def se_with_transactions_and_invoices(transactions, invoices)
    engine = SalesEngine.new
    engine.db_startup
    engine.transaction_repo_startup(transactions)
    engine.invoice_repo_startup(invoices)
    engine
  end
  def test_it_can_find_a_transaction_by_credit_card_number
    transaction_string  ="id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    1,1,4654405418249632,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,2,4580251236515201,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,4,4354495077693036,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,5,4515551623735607,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,6,4844518708741275,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,7,4203696133194408,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,8,4801647818676136,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,9,4540842003561938,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    9,10,4140149827486249,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC"
    
    engine = se_with_transactions(transaction_string)
    transaction = engine.transaction_repository.find_by_credit_card_number('4203696133194408')
    
    
    assert_equal 6, transaction.id
  end
  def test_a_transaction_has_a_corresponding_invoice
    transaction_string  ="id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    1,1,4654405418249632,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,2,4580251236515201,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,4,4354495077693036,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,5,4515551623735607,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,6,4844518708741275,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,7,4203696133194408,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,8,4801647818676136,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,9,4540842003561938,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    9,10,4140149827486249,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC"
    
    invoice_string = 'id,customer_id,merchant_id,status,created_at,updated_at
    1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
    5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
    6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC'
    
    engine = se_with_transactions_and_invoices(transaction_string, invoice_string)
    invoice = engine.transaction_repository.find_by(:invoice_id ,5).invoice

    
    assert_equal 41, invoice.merchant_id
    
  end
end
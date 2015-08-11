require_relative 'test_helper'


class InvoiceRepositoryTest < MiniTest::Test
  def se_with_invoices(invoices)
    engine = SalesEngine.new
    engine.db_startup
    engine.invoice_repo_startup(invoices)
    engine
  end
  def se_with_invoices_and_transactions(invoices, transactions)
    engine = SalesEngine.new
    engine.db_startup
    engine.invoice_repo_startup(invoices)
    engine.transaction_repo_startup(transactions)
    engine
  end
  def test_it_can_find_by_status
    invoice_string  ="id,customer_id,merchant_id,status,created_at,updated_at
    1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
    5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
    6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC
    7,1,44,shipped,2012-03-07 21:54:10 UTC,2012-03-07 21:54:10 UTC
    8,1,38,shipped,2012-03-13 16:54:10 UTC,2012-03-13 16:54:10 UTC
    9,2,27,shipped,2012-03-07 12:54:10 UTC,2012-03-07 12:54:10 UTC"
    
    engine = se_with_invoices(invoice_string)
    invoice = engine.invoice_repository.find_by_status('shipped')
    
    
    assert_equal 1, invoice.id
  end
  def test_it_can_find_by_customer_id
    invoice_string  ="id,customer_id,merchant_id,status,created_at,updated_at
    1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
    5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
    6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC
    7,1,44,shipped,2012-03-07 21:54:10 UTC,2012-03-07 21:54:10 UTC
    8,1,38,shipped,2012-03-13 16:54:10 UTC,2012-03-13 16:54:10 UTC
    9,2,27,shipped,2012-03-07 12:54:10 UTC,2012-03-07 12:54:10 UTC"
    
    engine = se_with_invoices(invoice_string)
    invoice = engine.invoice_repository.find_by_customer_id(2)
    
    
    assert_equal 9, invoice.id
  end
  def test_it_returns_nill_when_value_doesnt_exist
    invoice_string  ="id,customer_id,merchant_id,status,created_at,updated_at
    1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
    5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
    6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC
    7,1,44,shipped,2012-03-07 21:54:10 UTC,2012-03-07 21:54:10 UTC
    8,1,38,shipped,2012-03-13 16:54:10 UTC,2012-03-13 16:54:10 UTC
    9,2,27,shipped,2012-03-07 12:54:10 UTC,2012-03-07 12:54:10 UTC"
    
    engine = se_with_invoices(invoice_string)
    invoice = engine.invoice_repository.find_by_status('cool')
    
    
    assert invoice.nil?
  end
  def test_each_invoice_has_a_corresponding_transaction
    
    invoice_string  ="id,customer_id,merchant_id,status,created_at,updated_at
    1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
    2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
    3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
    4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
    5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
    6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC
    7,1,44,shipped,2012-03-07 21:54:10 UTC,2012-03-07 21:54:10 UTC
    8,1,38,shipped,2012-03-13 16:54:10 UTC,2012-03-13 16:54:10 UTC
    9,2,27,shipped,2012-03-07 12:54:10 UTC,2012-03-07 12:54:10 UTC"
    
    transaction_string = "id,invoice_id,credit_card_number,credit_card_expiration_date,result,created_at,updated_at
    1,1,4654405418249632,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,2,4580251236515201,,success,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,4,4354495077693036,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,5,4515551623735607,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,6,4844518708741275,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,7,4203696133194408,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,8,4801647818676136,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,9,4540842003561938,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    9,10,4140149827486249,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    10,11,4923661117104166,,success,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC"
    
    engine = se_with_invoices_and_transactions(invoice_string, transaction_string)
    
    transactions = engine.invoice_repository.find_by(:id, 8).transactions
    
    assert_equal 7, transactions[0].id
    
    
  end
  def test_we_can_make_a_new_invoice
    
    engine = mock_se_with_fixture_data
    customer = engine.customer_repository.find_by(:id, 3)
    merchant = engine.merchant_repository.find_by(:id, 4)
    invoice = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)
    
    assert_equal 30, invoice.id
    end
  end
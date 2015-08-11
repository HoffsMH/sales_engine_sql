require_relative 'test_helper'


class InvoiceRepositoryTest < MiniTest::Test
  def se_with_invoices(invoices)
    engine = SalesEngine.new
    engine.db_startup
    engine.invoice_repo_startup(invoices)
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
end
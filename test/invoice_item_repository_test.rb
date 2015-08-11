require_relative 'test_helper'


class InvoiceItemRepositoryTest < MiniTest::Test
  def se_with_invoice_items(invoice_items)
    engine = SalesEngine.new
    engine.db_startup
    engine.invoice_item_repo_startup(invoice_items)
    engine
  end
  def test_it_can_find_an_invoice_item
    invoice_item_string  ="id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    1,539,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,528,1,9,23324,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,523,1,8,34873,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    4,535,1,3,2196,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    5,529,1,7,79140,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    6,541,1,5,52100,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    7,530,1,4,66747,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    8,534,1,6,76941,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    9,1832,2,6,29973,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    10,1830,2,4,1859,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC"
    
    engine = se_with_invoice_items(invoice_item_string)
    invoice_item = engine.invoice_item_repository.find_by_item_id(530)

    
    assert_equal 7, invoice_item.id
  end
  def test_it_can_find_multiple_invoice_items
    invoice_item_string  ="id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    1,539,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,528,1,9,23324,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,523,1,8,34873,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    4,535,1,3,2196,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    5,529,1,7,79140,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    6,541,1,5,52100,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    7,530,1,4,66747,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    8,534,1,6,76941,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    9,1832,2,6,29973,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    10,1830,2,4,1859,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC"
    
    engine = se_with_invoice_items(invoice_item_string)
    merchants = engine.invoice_item_repository.find_all_by_quantity(5)
    
    assert_equal 2, merchants.size
  end
  
end
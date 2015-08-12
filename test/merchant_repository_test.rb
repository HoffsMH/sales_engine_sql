require_relative 'test_helper'


class MerchantRepositoryTest < MiniTest::Test
  def se_with_merchants(merchants)
    engine = SalesEngine.new
    engine.db_startup
    engine.merchant_repo_startup(merchants)
    engine
  end
  def test_it_can_find_a_merchant
    merchants_string  ="id,name,created_at,updated_at
    1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Willms and Sons,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Cummings-Thiel,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 16:12:25 UTC
    7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
    engine = se_with_merchants(merchants_string)
    merchant = engine.merchant_repository.find_by_name("Willms and Sons")

    
    assert_equal 3, merchant.id
  end
  def test_it_can_find_multiple_merchants
    merchants_string  ="id,name,created_at,updated_at
    1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Willms and Sons,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Cummings-Thiel,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 16:12:25 UTC
    7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
    engine = se_with_merchants(merchants_string)
    merchants = engine.merchant_repository.find_all_by(:name, "Williamson Group")
    
    assert_equal 2, merchants.size
  end
  
  def test_it_can_return_total_revenue
    date = Date.parse "2012-03-25"
    
    engine = mock_se_with_fixture_data
    revenue = engine.merchant_repository.revenue(date)
    
    assert_equal 21067.77, revenue
  end
  def test_it_can_return_top_merchants
    
    engine = mock_se_with_fixture_data
    top_merchants = engine.merchant_repository.most_revenue(3)

    assert_equal 3, top_merchants.size
    assert_equal "Balistreri, Schaefer and Kshlerin", top_merchants.first.name

  end
  def test_it_can_return_customers_with_pending_invoices
    
    engine = mock_se_with_fixture_data
    pending_merchants = engine.merchant_repository.find_by(:id , 1).customers_with_pending_invoices

    assert_equal 2, pending_merchants.size
  end
  
  def test_a_merchant_can_find_its_items
    
    engine = mock_se_with_fixture_data
    items = engine.merchant_repository.find_by(:id , 1).items

    assert_equal 15, items.size
  end
  
  def test_a_merchant_knows_its_revenue_with_no_date
    engine = mock_se_with_fixture_data
    revenue = engine.merchant_repository.find_by(:id , 26).revenue

    assert_equal 26356.9, revenue
    
  end
  def test_a_merchant_knows_its_revenue_with_a_date
    engine = mock_se_with_fixture_data
    revenue = engine.merchant_repository.find_by(:id , 26).revenue("2012-03-25")

    assert_equal 2106777, revenue
    
  end
  
  def test_a_merchant_knows_his_favorite_color
    engine = mock_se_with_fixture_data
    fav_customer = engine.merchant_repository.find_by(:id , 26).favorite_customer

    assert_equal "Joey", fav_customer.first_name
    
  end
  
  def test_it_has_a_simple_inspect_representation
    engine = mock_se_with_fixture_data
    merchant = engine.merchant_repository.find_by(:id , 26)

    assert_equal "Merchant", merchant.inspect
    
  end
  
end
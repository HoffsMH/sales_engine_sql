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
    assert_equal "someName", top_merchants.first.name

  end
  
end
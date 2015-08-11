require_relative 'test_helper'


class RepositoryTest < MiniTest::Test
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
    merchant = engine.merchant_repository.find_by(:id, 3)

    
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
  
end
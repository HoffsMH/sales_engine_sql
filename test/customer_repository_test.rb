require_relative 'test_helper'


class CustomerRepositoryTest < MiniTest::Test
  def se_with_customers(customers)
    engine = SalesEngine.new
    engine.db_startup
    engine.customer_repo_startup(customers)
    engine
  end
  def test_it_can_find_by_first_name
    customer_string  ="1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,Sylvester,Nader,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,Heber,Kuhn,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,Parker,Daugherty,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,Loyal,Considine,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    9,Dejon,Fadel,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    10,Ramona,Reynolds,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    11,Logan,Kris,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    12,Ilene,Pfannerstill,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    13,Katrina,Hegmann,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
"
    
    engine = se_with_customers(customer_string)
    customer = engine.customer_repository.find_by_first_name('Dejon')

    
    assert_equal 9, customer.id
  end
  def test_it_returns_nill_when_value_doesnt_exist
    customer_string  ="1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,Sylvester,Nader,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,Heber,Kuhn,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,Parker,Daugherty,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,Loyal,Considine,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    9,Dejon,Fadel,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    10,Ramona,Reynolds,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    11,Logan,Kris,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    12,Ilene,Pfannerstill,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    13,Katrina,Hegmann,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
"
    
    engine = se_with_customers(customer_string)
    customer = engine.customer_repository.find_by_first_name('casdfasf')

    
    assert customer.nil?
  end
  
  
  def test_it_can_find_by_last_name
    customer_string  ="1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    5,Sylvester,Nader,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    6,Heber,Kuhn,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    7,Parker,Daugherty,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
    8,Loyal,Considine,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    9,Dejon,Fadel,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    10,Ramona,Reynolds,2012-03-27 14:54:11 UTC,2012-03-27 14:54:11 UTC
    11,Logan,Kris,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    12,Ilene,Pfannerstill,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
    13,Katrina,Hegmann,2012-03-27 14:54:12 UTC,2012-03-27 14:54:12 UTC
"
    
    engine = se_with_customers(customer_string)
    customer = engine.customer_repository.find_by_last_name('Considine')

    
    assert_equal 8, customer.id
  end
  def test_a_customer_can_bring_up_invoices
    
    engine = mock_se_with_fixture_data
    invoices = engine.customer_repository.find_by(:id, 1).invoices
    
    assert_equal 8, invoices.size
  end
  def test_a_customer_can_bring_up_the_right_invoices
    
    engine = mock_se_with_fixture_data
    invoices = engine.customer_repository.find_by(:id,1).invoices
    assert invoices[0]
    assert_equal 1, invoices[0].id
  end
  def test_a_customer_can_bring_up_transactions
    
    engine = mock_se_with_fixture_data
    transactions = engine.customer_repository.find_by(:id,1).transactions
    
    assert_equal 7, transactions.size
  end
  def test_a_customer_can_bring_up_the_right_transaction
    
    engine = mock_se_with_fixture_data
    transactions = engine.customer_repository.find_by(:id,1).transactions
    assert transactions[0]
    assert_equal 1, transactions[0].id
  end
  
  def test_a_customer_can_have_a_favorite_merchant
    
    engine = mock_se_with_fixture_data
    fav_merchant = engine.customer_repository.find_by(:id, 1).favorite_merchant
    
    assert fav_merchant
    assert_kind_of Merchant, fav_merchant
    assert_equal 34, fav_merchant.id
  end
  
  
end
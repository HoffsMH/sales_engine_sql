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
end
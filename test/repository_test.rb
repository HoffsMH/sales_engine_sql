require_relative 'test_helper'


class RepositoryTest < MiniTest::Test
  def test_we_can_start_a_customer_repo
    engine = SalesEngine.new
    engine.db_startup
    
    assert_operator engine.db.execute( "select * from customers" ).size , :>, 100
  end
  def test_we_can_find_a_specific_customer
    engine = SalesEngine.new
    engine.db_startup
    
    customer = engine.customer_repository.find_by(:id, 3)
    
    assert_equal 'Mariah', customer.first_name
    
  end
  def test_we_can_find_more_than_one_customer
    engine = SalesEngine.new
    engine.db_startup
    customers = engine.customer_repository.find_all_by(:first_name, 'Sasha')
    
    assert_equal 2, customers.size
    
  end
end


require_relative 'test_helper'


class RepositoryTest < MiniTest::Test
  def setup
    @engine = SalesEngine.new
    @test_4_customers = "id,first_name,last_name,created_at,updated_at
1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC"
    @engine.db_startup
    @engine.customer_repo_startup(@test_4_customers)
  end

  def test_we_can_start_a_customer_repo
    assert_operator @engine.db.execute( "select * from customers" ).size , :>, 2
  end

  def test_we_can_find_a_specific_customer
    customer = @engine.customer_repository.find_by(:id, 3)
    assert_equal 'Mariah', customer.first_name
  end

  def test_we_can_find_more_than_one_customer
    @engine.db_startup
    @engine.customer_repo_startup
    customers = @engine.customer_repository.find_all_by(:first_name, 'Sasha')
    assert_equal 2, customers.size
  end
end


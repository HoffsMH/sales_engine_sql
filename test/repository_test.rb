require_relative 'test_helper'


class RepositoryTest < MiniTest::Test
  
  def se_with_customers(customers=default_customers)
    engine = SalesEngine.new
    engine.db_startup
    engine.customer_repo_startup(customers)
    engine
  end
  def se_with_invoices(invoices=default_invoices)
    engine = SalesEngine.new
    engine.db_startup
    engine.invoice_repo_startup(invoices)
    engine
  end
def default_invoices
  "id,customer_id,merchant_id,status,created_at,updated_at
1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC"
end
  def default_customers
    "id,first_name,last_name,created_at,updated_at
1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
5,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC"
    
  end
  
  def test_we_can_start_a_customer_repo
    engine = se_with_customers
    assert_operator engine.db.execute( "select * from customers" ).size , :>, 2
  end
  
  def test_we_can_find_a_specific_customer
    engine = se_with_customers
    customer = engine.customer_repository.find_by_id(3)
    assert_equal 'Mariah', customer.first_name
  end
  
  def test_we_can_find_more_than_one_customer
    engine = se_with_customers
    customers = engine.customer_repository.find_all_by(:first_name, 'Joey')
    assert_equal 2, customers.size
  end
  def test_all_returns_all_of_objects_of_the_correct_type
    engine = se_with_invoices
    invoices =  engine.invoice_repository.all
    assert invoices.all? do |invoice|
      invoice.class == Invoice
    end
    assert_equal 6, invoices.size
  end
  def test_random_doesnt_return_the_same_instance_twice
    engine = se_with_invoices
    invoice1 =  engine.invoice_repository.random
    invoice2 =  engine.invoice_repository.random
    
    assert invoice1 != invoice2.id
  end
  def test_good_date_it_trims_a_date_string_when_given_a_date_object
    engine = se_with_customers
    test_date = Date.parse("2012-07-23 14:23:43 UTC")
    result = engine.customer_repository.good_date(test_date)
    
    assert_equal('2012-07-23', result)
  end
  def test_good_date_it_trims_a_date_string_when_given_a_date_string
    engine = se_with_customers
    result = engine.customer_repository.good_date("2012-07-23 14:23:43 UTC")
    
    assert_equal('2012-07-23', result)
  end
  def test_it_returns_a_non_recursive_representation_of_itself_upon_inspec
    engine = se_with_customers
    result = engine.customer_repository.inspect
    
    assert_equal CustomerRepository, result
  end
end


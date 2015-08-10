require_relative 'test_helper'


class RepositoryTest < MiniTest::Test
  def setup
    @engine = SalesEngine.new
    @test_4_customers = "id,first_name,last_name,created_at,updated_at
1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
2,Cecelia,Osinski,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC"
    @test_6_invoices = "id,customer_id,merchant_id,status,created_at,updated_at
1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
2,1,75,shipped,2012-03-12 05:54:09 UTC,2012-03-12 05:54:09 UTC
3,1,78,shipped,2012-03-10 00:54:09 UTC,2012-03-10 00:54:09 UTC
4,1,33,shipped,2012-03-24 15:54:10 UTC,2012-03-24 15:54:10 UTC
5,1,41,shipped,2012-03-07 19:54:10 UTC,2012-03-07 19:54:10 UTC
6,1,76,shipped,2012-03-09 01:54:10 UTC,2012-03-09 01:54:10 UTC"
    @engine.db_startup
    @engine.customer_repo_startup(@test_4_customers)
    @engine.invoice_repo_startup(@test_6_invoices)
  end
  def test_startup_inits_all_of_our_repos_successfully
    test_engine = SalesEngine.new
    test_engine.startup

    
    assert test_engine.customer_repository
    assert test_engine.invoice_repository
    assert test_engine.transaction_repository
    
  end
end
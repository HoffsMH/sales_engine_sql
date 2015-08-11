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
@test_8_merchants = "id,name,created_at,updated_at
1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
3,Willms and Sons,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
4,Cummings-Thiel,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
5,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
6,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 16:12:25 UTC
7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
@test_9_items = "d,name,description,unit_price,merchant_id,created_at,updated_at
1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
2,Item Autem Minima,Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.,67076,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
3,Item Ea Voluptatum,Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.,32301,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
4,Item Nemo Facere,Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.,4291,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
5,Item Expedita Aliquam,Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.,68723,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
6,Item Provident At,Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.,15925,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
7,Item Expedita Fuga,Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.,31163,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
8,Item Est Consequuntur,Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.,34355,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
9,Item Quo Magnam,Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.,22582,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    @engine.db_startup
    # @engine.customer_repo_startup(@test_4_customers)
    # @engine.invoice_repo_startup(@test_6_invoices)
    # @engine.merchant_repo_startup(@test_8_merchants)
    # @engine.item_repo_startup(@test_9_items)
  end
  def test_startup_inits_all_of_our_repos_successfully
    test_engine = SalesEngine.new('../sales_engine/fixtures')
    test_engine.startup

    
    assert test_engine.customer_repository
    assert test_engine.invoice_repository
    assert test_engine.transaction_repository
    assert test_engine.merchant_repository
    assert test_engine.item_repository
    
  end
end
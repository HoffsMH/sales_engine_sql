require_relative 'test_helper'


class ItemTest < MiniTest::Test
  def se_with_items(items)
    engine = SalesEngine.new
    engine.db_startup
    engine.item_repo_startup(items)
    engine
  end
  def se_with_items_and_invoice_items(items, invoice_items)
    engine = SalesEngine.new
    engine.db_startup
    engine.item_repo_startup(items)
    engine.invoice_item_repo_startup(invoice_items)
    engine
  end
  def se_with_items_and_merchants(items, merchants)
    engine = SalesEngine.new
    engine.db_startup
    engine.item_repo_startup(items)
    engine.merchant_repo_startup(merchants)
    engine
  end
  def test_it_can_find_by_id
    item_string  ="id,name,description,unit_price,merchant_id,created_at,updated_at
    1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    2,Item Autem Minima,Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.,67076,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Item Ea Voluptatum,Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.,32301,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Item Nemo Facere,Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.,4291,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Item Expedita Aliquam,Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.,68723,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Item Provident At,Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.,15925,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    7,Item Expedita Fuga,Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.,31163,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    8,Item Est Consequuntur,Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.,34355,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    9,Item Quo Magnam,Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.,22582,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
    engine = se_with_items(item_string)
    item = engine.item_repository.find_by(:id, 5)

    
    assert_equal 'Item Expedita Aliquam', item.name
  end
  def test_it_has_corresponding_invoice_items
    item_string  ="id,name,description,unit_price,merchant_id,created_at,updated_at
    1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    2,Item Autem Minima,Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.,67076,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Item Ea Voluptatum,Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.,32301,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Item Nemo Facere,Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.,4291,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Item Expedita Aliquam,Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.,68723,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Item Provident At,Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.,15925,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    7,Item Expedita Fuga,Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.,31163,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    8,Item Est Consequuntur,Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.,34355,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    9,Item Quo Magnam,Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.,22582,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
    invoice_item_string = "id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
    1,539,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    2,528,1,9,23324,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    3,2,1,8,34873,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    4,535,1,3,2196,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    5,529,1,7,79140,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    6,541,1,5,52100,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    7,530,1,4,66747,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    8,534,1,6,76941,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    9,1832,2,6,29973,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
    10,1830,2,4,1859,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC"
    
    engine = se_with_items_and_invoice_items(item_string, invoice_item_string)
  
    invoice_items = engine.item_repository.find_by(:id, 2).invoice_items

    
    assert_equal 3, invoice_items[0].id
  end
  def test_each_item_has_a_corresponding_merchant
    
    item_string  ="id,name,description,unit_price,merchant_id,created_at,updated_at
    1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    2,Item Autem Minima,Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.,67076,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Item Ea Voluptatum,Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.,32301,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Item Nemo Facere,Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.,4291,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Item Expedita Aliquam,Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.,68723,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Item Provident At,Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.,15925,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    7,Item Expedita Fuga,Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.,31163,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    8,Item Est Consequuntur,Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.,34355,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    9,Item Quo Magnam,Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.,22582,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
    merchant_string = "id,name,created_at,updated_at
    1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    2,\"Klein, Rempel and Jones\",2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Willms and Sons,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Cummings-Thiel,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Williamson Group,2012-03-27 14:53:59 UTC,2012-03-27 16:12:25 UTC
    7,Bernhard-Johns,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    8,\"Osinski, Pollich and Koelpin\",2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    9,Hand-Spencer,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    10,\"Bechtelar, Jones and Stokes\",2012-03-27 14:54:00 UTC,2012-03-27 14:54:00 UTC"
    
    engine = se_with_items_and_merchants(item_string, merchant_string)
    
    merchant = engine.item_repository.find_by(:id, 2).merchant
    
    assert_equal "Schroeder-Jerde", merchant.name
    
  end
  def test_each_item_has_a_best_day
    
    item_string  ="id,name,description,unit_price,merchant_id,created_at,updated_at
    1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    2,Item Autem Minima,Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.,67076,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    3,Item Ea Voluptatum,Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut.,32301,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    4,Item Nemo Facere,Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.,4291,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    5,Item Expedita Aliquam,Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.,68723,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    6,Item Provident At,Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias asperiores minima ducimus nesciunt at.,15925,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    7,Item Expedita Fuga,Fuga assumenda occaecati hic dolorem tenetur dolores nisi. Est tenetur adipisci voluptatem vel. Culpa adipisci consequatur illo. Necessitatibus quis quo velit sed repellendus ut amet.,31163,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    8,Item Est Consequuntur,Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.,34355,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
    9,Item Quo Magnam,Culpa deleniti adipisci voluptates aut. Sed eum quisquam nisi. Voluptatem est rerum est qui id reprehenderit. Molestiae laudantium non velit alias. Ipsa consequatur modi quibusdam.,22582,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC"
    
  end
  def test_repository_most_items_returns_the_right_amount_of_items
    engine = mock_se_with_fixture_data
    items = engine.item_repository.most_items(1)
    assert items
    assert_kind_of Item, items[0]
    assert_equal 1, items.size
  end
  def test_repository_most_items_returns_the_right_items
    engine = mock_se_with_fixture_data
    items = engine.item_repository.most_items(1)
    assert items
    assert_kind_of Item, items[0]
    assert_equal 1, items.size
    assert_equal 15, items[0].id
  end
  def test_repository_most_revenue_returns_the_right_item
    engine = mock_se_with_real_data
    items = engine.item_repository.most_revenue(1)
    #cant figure out how to plug this into either fixtures or
    #mock data works in pry and in spec harness
    assert_equal nil, items[0].id
  end
  
  def test_repository_most_revenue_returns_the_right_amount_of_items
    engine = mock_se_with_fixture_data
    items = engine.item_repository.most_revenue(3)
  
    assert_equal 3, items.size
  end
  def test_repository_most_revenue_returns_the_right_item
    engine = mock_se_with_real_data
    items = engine.item_repository.most_revenue(1)
    #cant figure out how to plug this into either fixtures or
    #mock data works in pry and in spec harness
    assert_equal 227, items[0].id
  end
  def test_an_item_knows_its_best_day
    engine = mock_se_with_fixture_data
    best_day = engine.item_repository.find_by(:id, 3).best_day
    
    assert_equal 1, best_day
  end
end
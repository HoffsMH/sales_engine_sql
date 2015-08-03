require_relative 'repo'
require_relative 'customer'

class CustomerRepository < Repo
  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Customer,'../sales_engine/data/customers.csv')
  end




end

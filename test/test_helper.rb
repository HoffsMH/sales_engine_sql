require 'simplecov'

SimpleCov.start
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

def mock_se_with_fixture_data
  engine = SalesEngine.new('../sales_engine/fixtures')
  engine.startup
  engine
end
def mock_se_with_real_data
  engine = SalesEngine.new('../sales_engine/data')
  engine.startup
  engine
end

def real_engine 
  engine ||= mock_se_with_real_data
  engine
end
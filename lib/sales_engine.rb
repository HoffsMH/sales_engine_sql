require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'repository'
require 'sqlite3'
require 'pry'


class SalesEngine
  attr_reader :customer_repository, :invoice_repository,
              :transaction_repository, :invoice_item_repository,
               :merchant_repository, :item_repository, :csv_path, :db

  def initialize(csv_path = our_folder)
    @csv_path = csv_path
  end

  def our_folder
    our_root = File.expand_path('../..',  __FILE__)
    File.join our_root, "data"
  end

  def startup
    
  end
  def db_startup
    if File.file?('data.db') 
      File.delete('data.db')
    end
    @db = SQLite3::Database.new 'data.db'
    customers = File.read(File.join @csv_path, 'customers.csv')

    @customer_repository = CustomerRepository.new(self, customers, db)
  end

end

engine = SalesEngine.new()

engine.db_startup
if __FILE__ == $0
  puts "Using csv folder.... #{engine.csv_path}"
  binding.pry
end

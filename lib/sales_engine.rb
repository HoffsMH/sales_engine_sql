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
    db_startup
    customer_repo_startup
    invoice_repo_startup
    transaction_repo_startup
    merchant_repo_startup
    item_repo_startup
    invoice_item_repo_startup
  end
  def db_startup
    if File.file?('data.db') 
      File.delete('data.db')
    end
    @db = SQLite3::Database.new 'data.db'     
  end
  def customer_repo_startup(customers=nil)
    customers ||= File.read(File.join @csv_path, 'customers.csv')
    @customer_repository = ""
    @customer_repository = CustomerRepository.new(self, customers, db)
  end
  
  def invoice_repo_startup(invoices=nil)
    invoices ||= File.read(File.join @csv_path, 'invoices.csv')
    @invoice_repository = ""
    @invoice_repository = InvoiceRepository.new(self, invoices, db)
  end
  
  def transaction_repo_startup(transactions=nil)
    transactions ||= File.read(File.join @csv_path, 'transactions.csv')
    @transaction_repository = ""
    @transaction_repository = TransactionRepository.new(self, transactions, db)
  end
  def merchant_repo_startup(merchants=nil)
    merchants ||= File.read(File.join @csv_path, 'merchants.csv')
    @merchant_repository = ""
    @merchant_repository = MerchantRepository.new(self, merchants, db)
  end
  def item_repo_startup(items=nil)
    items ||= File.read(File.join @csv_path, 'items.csv')
    @item_repository = ""
    @item_repository = ItemRepository.new(self, items, db)
  end
  def invoice_item_repo_startup(invoice_items=nil)
    invoice_items ||= File.read(File.join @csv_path, 'invoice_items.csv')
    @invoice_item_repository = ""
    @invoice_item_repository = InvoiceItemRepository.new(self, invoice_items, db)
  end

end

engine = SalesEngine.new()

engine.db_startup
if __FILE__ == $0
  puts "Using csv folder.... #{engine.csv_path}"
  binding.pry
end

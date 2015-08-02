require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionRepoTest < MiniTest::Test


  @@engine = SalesEngine.new
    @@engine.startup

    def engine
      @@engine
    end

    def test_invoice__it_can_pull_an_invoice
      transaction = engine.transaction_repo.find_by(:id, '3')

      assert_equal Invoice, transaction.invoice.class
    end

    def test_merchant__it_pulls_the_correct_invoice
      transaction = engine.transaction_repo.find_by(:id, '3')

      assert_equal '4', transaction.invoice.id
      assert_equal '33', transaction.invoice.merchant_id
    end
    def test_success__it_returns_true_when_a_given_transaction_is_sucessful
      
      input_data =['1', '2', '9381938102', "1918", 'success', '08071902', '01929382']
      transaction = Transaction.new(input_data, engine.transaction_repo)
      
      assert transaction.successful?
      
    end
    def test_sucess__it_returns_false_when_a_given_transaction_is_unsuccessful
      #give invoice id that coudln't possibly exist elsewhere
      input_data =['1', '2342352352352', '9381938102', "1918", 'failed', '08071902', '01929382']
      transaction = Transaction.new(input_data, engine.transaction_repo)
      
      assert_equal(false, transaction.successful?)
      
    end



  # def test_can_find_invoice
  #   engine = SalesEngine.new
  #   engine.startup
  #   engine.transaction_repo.map_data(Transaction,'test/fixtures/transactions.csv')
  #   engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')
  #
  #   assert_equal '26', engine.transaction_repo.invoice('1').merchant_id
  # end

end
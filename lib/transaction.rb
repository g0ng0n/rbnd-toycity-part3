class Transaction
	attr_reader :customer, :product, :id

    @@transactions = []

	def initialize(customer,product)
		
		@customer = customer
		@product = product
		if (Product.check_stock(@product))
			add_to_transactions
		else
			raise OutOfStockError, "'#{@product.title}' is out of stock.."
		end
  	end

  	#gets all the transactions
  	def self.all
  		@@transactions
  	end

  	#retrieve the transactionn, by sending the id
  	def self.find(id)

  		
  		transaction = Transaction.all.bsearch{|t| id.to_s.eql?(t.id) }

		if transaction.instance_of?(NilClass)
	  		raise TransactionNotFoundError, "Transaction: #{id} not found"
	  	else
	  		return transaction
	  	end
  	end

  	#check if the transaction is included by sending the id
	#into the method
  	def self.transaction_include_by_id?(id)
	  	Transaction.all.each do |transaction|

		  	if transaction.id.eql?(id)
	        	return true 
		  	else
		  		return false
		  	end
		  
	    end	

  	end

  	def self.print_all_transactions

    	UI.print_line_separator
    	puts "Transactions Report"
    	UI.print_line_separator
    	counter = 1;
    	@@transactions.each do |transaction|
    		puts "Id: #{transaction.id} made by #{transaction.customer.name} with #{transaction.product.get_total_prod} Products";
    		counter +=1;
    	end
    	UI.print_line_separator
    	puts "-> End Of Transaction report"
    	UI.print_line_separator
    end

  	private
    #Method that provides the functionality to add a transactions into the 
    #Transactions class variable array
    def add_to_transactions()

		create_id
		puts "id created"
		puts @id
		#we validate if we have transactions in the array, if so we check if the transaction
	  	#that we want to add is already there
	    if @@transactions.count >0

	    	if Transaction.transaction_include_by_id?(self.id)
	        	raise DuplicateProductError, "#{self.id} already exists."
	    	else
	    		@@transactions.push(self)
			end

		else

	      @@transactions.push(self)
	    end
	end

	def create_id
		new_id = Transaction.all.count + 1
    	@id = new_id.to_s
  	end
end
class Transaction
	attr_reader :customer, :product, :id

    @@transactions = []

	def initialize(customer,product)
		
		@customer = customer
		@product = product
		create_id
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
  		Transaction.all.each do |transaction|

		  	if transaction.id.eql?(id)
	  			return transaction
	  		end
	  	end

    	return nil
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


  	private
    #Method that provides the functionality to add a transactions into the 
    #Transactions class variable array
    def add_to_transactions()
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
    	@id = Transaction.all.count + 1
  	end
end
class Customer
    attr_reader :name

    @@customers = []

	def initialize(options={})
		@name = options[:name]

		add_to_customers
  	end

  	def purchase(product)
  		Transaction.new(self,product)

  	end


  	#retrieve the customer, by sending the name
  	def self.find_by_name(name)
	  	Customer.all.each do |customer|
		  	if customer.name.eql?(name)
		  		return customer
		  	end
		  end

	    return nil
	end

	#check if the customer is included by sending the name
	#into the method
  	def self.customer_include_by_name?(name)
	  	Customer.all.each do |customer|

		  	if customer.name.eql?(name)
	        	return true
		  	else
		  		return false
		  	end

	    end

  	end


  	#retrieve the array of customers
  	def self.all
    	@@customers
  	end

    private
    #Method that provides the functionality to add a customers into the
    #Customers class variable array
    def add_to_customers()
		#we validate if we have customers in the array, if so we check if the customer
	  	#that we want to add is already there
	    if @@customers.count >0
        begin
	         if Customer.customer_include_by_name?(self.name)
             raise DuplicateProductError
           else
 	    		     @@customers.push(self)
 			     end
        rescue
           puts "#{self.name} already exists."
        end
		  else
	      @@customers.push(self)
	    end
	end

end

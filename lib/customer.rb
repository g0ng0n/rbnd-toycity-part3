class Customer
    attr_reader :name

    @@customers = []

	def initialize(options={})
		@name = options[:name] 

		add_to_customers
  	end

  	def self.find_by_name(name)
	  	Customer.all.each do |customer|
		  	if customer.name.eql?(name)
		  		return customer
		  	end
		  end

	    return nil
	end

  	def self.customer_include_by_title?(name)
	  	Customer.all.each do |customer|

		  	if customer.name.eql?(name)
	        	return true 
		  	else
		  		return false
		  	end
		  
	    end	

  	end

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

	    	if Customer.customer_include_by_title?(self.name)
	        raise DuplicateProductError, "#{self.name} already exists."
	    	else
	    		@@customers.push(self)
			  end

		  else
	      @@customers.push(self)
	    end
	end
end

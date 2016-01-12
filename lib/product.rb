class Product
  attr_reader :title

  @@products = []

  def initialize(options={})
    @title = options[:title]
   	add_to_products
  end

  def self.all
    @@products
  end

  private

  #Method that provides the functionality to add a product into the 
  #Products class variable array
  def add_to_products
  	#we validate that the @@products has at least 1 prod 
    #if not we add the without the duplicate validation
    
    if @@products.count >0
	  	Product.all.each do |product|
	  		if product.title.eql?(self.title)  			
	    		raise DuplicateProductError, "LEGO Iron Man vs. Ultron already exists. "
	    	else	
	    		puts product.title
	   			@@products << self
			end

	  	end	
	else
    	@@products<<self
    end

   
  end
end
class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]

   	add_to_products
  end

  #retrieve the array of products
  def self.all
    @@products
  end

  #retrieve the customer, by sending the title
  def self.find_by_title(title)
  	Product.all.each do |product|
	  	if product.title.eql?(title)
	  		return product
	  	end
	  end

    return nil
  end

  #retrieve true if there is stock of the product
  def self.check_stock(product)

    if product.in_stock?
      Product.reduce_stock(product)
      return true
    else
      return false
    end 

  end


  #check if the customer is included by sending the name
  #into the method
  def self.product_include_by_title?(title)
  	Product.all.each do |product|

	  	if product.title.eql?(title)
        return true 
	  	else
	  		return false
	  	end
	  
    end	

  end
  

  #this method should return  an Array of 
  #all products with a stock greater than zero.
  def self.in_stock()
      array_response = Array.new
      Product.all.each do |product|

        if product.in_stock?
          array_response.push(product)
        end
      end 

      if array_response.count>0
        return array_response
      else
        puts "We have no Stock of toys!!"
        return nil
      end
  end

  #this method should return if there is stock of the toy
  def in_stock?()
    if self.stock >0
      return true
    else
     return false
    end
  end

  def stock=(new_stock)
    @stock = new_stock
  end
  private
  #Method that provides the functionality to add a product into the 
  #Products class variable array
  def add_to_products()
  	#we validate if we have products in the array, if so we check if the product
  	#that we want to add is already there
    if @@products.count >0

    	if Product.product_include_by_title?(self.title)
        raise DuplicateProductError, "#{self.title} already exists."
    	else
    		@@products.push(self)
		  end

	  else
      @@products.push(self)
    end
  end

  def self.reduce_stock(product)
    product.stock = product.stock - 1
  end
end
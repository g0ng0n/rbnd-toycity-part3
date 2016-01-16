class UI

	def initialize
		@exit=false
		#this is the array that is going to be storing the to-do list created
		#generate_dummy_data()
	    start_ui
	end

	#method that starts the UI.
	def start_ui
	    while @exit==false
	      show_options
	      action = UI.take_user_input
	      take_action(action)
	    end
	    system("clear")
	    puts "-> End of Program"
	end

	def self.take_user_input
	    puts "-> Please Choose an Option "
	    print "> "
	  	gets.chomp.to_s
	end

	def self.select_name
		puts "-> Plase choose a name "
		print "> "
		gets.chomp.to_s

	end


	def welcome_message(message)
		sleep(1)
    	system("clear")
    	puts message
	end


	def self.print_line_separator
	    puts '-' * 20
	end

	def self.print_delete_message(item_description)
		puts "-> Item " + item_description + " Deleted"
	end

	private
	def show_options
		puts" -----------Principal Menu------------------"
		puts"|1) Print Transaction Report   			|"
		puts"|2) Print Report Detail of a Selected Transaction|"
		puts"|0) Exit                   			|"
		puts" -------------------------------------------"

	end

	def take_action(action)

		case action
	    when "1"
	      print_report
	    when "2"
	      print_report_detail
	    when "0"
	      @exit=true
	    else
				puts "You entered a wrong action, Please try Again!"
				welcome_message "Heading back to the main menu...."
			end
    end

    def print_report_detail
    	welcome_message("2) Print Report Detail of a Selected Transaction")
		transaction_id = user_input_message("Please insert ID of the transaction you want to print the detail")
		transaction = Transaction.find(transaction_id)

		print_detail(transaction)

    end

    def print_detail(transaction)
    	puts"|-----Detail of Transaction----"
	    puts"| Id: #{transaction.id}"
	    puts"| Customer: #{transaction.customer.name}"
	    puts"| List of Products"

		print_products(transaction.product)
    end

    def print_products(product)
	    	puts"|Title: #{product.title}"
	    	puts"|Price: #{product.price}"
	    	UI.print_line_separator
    end

    def print_report
    	welcome_message("1) Print Transaction Report")
    	Transaction.print_all_transactions
    end

    def list_message(message)
    	puts message
		puts "if you want to check all the list, select option 4 in the Principal Menu"
	end

	def welcome_message(message)
		sleep(1)
    	system("clear")
    	puts message
	end

	def user_input_message(message)
		puts message
		user_input = UI.take_user_input
		return user_input.to_s
	end



end

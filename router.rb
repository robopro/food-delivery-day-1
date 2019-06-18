# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    while @running
      display_actions
      action = gets.chomp.to_i
      print `clear`
      perform(action)
    end
  end

  def display_actions
    puts ""
    puts "** *** **** *** **"
    puts "*** ** MENU ** ***"
    puts "** *** **** *** **"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "0 - Quit"
    puts "CTRL + C - Rage Quit"
  end

  def perform(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 0 then @running = false
    else puts "Not an option!"
    end
  end
end

require_relative '../views/customers_view'

class CustomersController
  def initialize(customers_repo)
    @customers_repo = customers_repo
    @view = CustomersView.new
  end

  def list
    # displays all customers to user
    # get all customers
    # customers = @customers_repo.all
    @view.display(@customers_repo.all)
  end

  def add
    # create new customer and add to repo
    # ask user for name and price
    attributes = {
      name: @view.ask_for_string(:name),
      address: @view.ask_for_string(:address)
    }
    # make new customer object
    # pass that to the repo
    @customers_repo.add(Customer.new(attributes))
  end
end

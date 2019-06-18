require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_path)
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    save_csv
    @next_id += 1
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_path, options) do |row|
      row[:id] = row[:id].to_i
      @customers << Customer.new(row)
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_csv
    CSV.open(@csv_path, 'wb') do |csv|
      csv << %i[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end

require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_path)
  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    save_csv
    @next_id += 1
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_path, options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_csv
    CSV.open(@csv_path, 'wb') do |csv|
      csv << %i[id name price]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

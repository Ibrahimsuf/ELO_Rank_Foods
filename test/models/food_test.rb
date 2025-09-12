require "test_helper"

class FoodTest < ActiveSupport::TestCase
  test "correct updates the elo on a win" do
    food1 = Food.new(name: "Sample", image_filename: "Sample", elo: 1613)
    food2 = Food.new(name: "Sample2", image_filename: "Sample2", elo: 1609)
    food1.win(food2)
    assert (food1.elo - 1628).abs < 2
  end
  test "correctly updates the elo on a loss" do
    food1 = Food.new(name: "Sample", image_filename: "Sample", elo: 1613)
    food2 = Food.new(name: "Sample2", image_filename: "Sample2", elo: 1609)
    food1.loss(food2)
    assert (food1.elo - 1596.68).abs < 2
  end
end

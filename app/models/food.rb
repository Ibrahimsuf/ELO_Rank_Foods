class Food < ApplicationRecord
  def win(food2)
    update!(elo: elo+K*(1-win_probability(food2)))
  end
  def lose(food2)
    puts "Calling loss"
    update!(elo: elo-K*win_probability(food2))
  end
  private
  K = 32
  def win_probability(food2)
    1.0/(1.0 + 10.0 ** ((elo - food2.elo)/400.0))
  end
end

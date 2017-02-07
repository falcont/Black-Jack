# Player class
class Player

  attr_accessor :name
  attr_accessor :balance
  attr_accessor :cards
  attr_accessor :score

  def initialize(name: name)
    @name = name
    @balance = 100
    @score = 0
    @cards = []
  end

  def cards=(cards)
    cards.each { |card| @cards << card }
  end

  def bet
    @balance -= 10
    10
  end


  def calculate_score
    score = 0
    @cards.each do |card|
      card.values.each do |value|
        if %w(J Q K).include? value.strip
          score += 10
        elsif value.strip == 'A' && @score < 11
          score += 11
        elsif value.strip == 'A' && @score >= 11
          score += 1
        else 
          score += value.to_i
        end
      end
    end
    @score = score
  end
end

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

  # def set_name
  #   print "Enter your name: "
  #   @name = gets.chomp
  # end

  def get_cards(cards)
    cards.each { |card| @cards << card }
  end

  def bet
    @balance -= 10
    10
  end

  def calculate_score
    score_cards = []
    if @score == 0
      score_cards = @cards
    else 
      score_cards << @cards.last
    end
    score_cards.each do |card|
      card.values.each do |value|
        if %w(J Q K).include? value.strip
          @score += 10
        elsif value.strip == 'A' && @score < 11
          @score += 11
        elsif value.strip == 'A' && @score >= 11
          @score += 1
        else 
          @score += value.to_i
        end
      end
    end
    @score
  end

end

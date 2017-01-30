# Deck class
class Deck

  attr_accessor :deck
  attr_accessor :random_card
  
  def initialize
    create_desk
    shuffle_deck  
  end


  def create_desk
    suits = %w(♣ ♠ ♥ ♦)
    faces = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits.each do |suit|
      faces.each do |face|
        (@deck ||= []) << {suit => face}
      end
    end 
  end

  def shuffle_deck
    @deck.shuffle!
  end

  def take_card
    @random_card = @deck.sample
    @deck.delete(@random_card)
  end

end


deck = Deck.new
deck.shuffle_deck
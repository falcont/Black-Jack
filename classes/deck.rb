# Deck class
class Deck

  SUITS = %w(♣ ♠ ♥ ♦).freeze
  #faces = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  FACES = ['2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 ', '9 ', '10', 'J ', 'Q ', 'K ', 'A '].freeze #все же оставлю так, иначе нужно будет сильно переделывать вывод



  attr_reader :deck

  def initialize
    @deck = nil
    create_deck
  end

  def deal_cards(n)
    cards = []
    n.times { cards << take_card }
    cards
  end

  private

  def create_deck
    SUITS.each do |suit|
      FACES.each do |face|
        (@deck ||= []) << { suit => face }
      end
    end
    @deck.shuffle!
  end


  def take_card
    @random_card = @deck.pop
  end

end

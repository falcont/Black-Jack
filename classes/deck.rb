# Deck class
class Deck

  def initialize
    create_deck
    shuffle_deck 
  end


  def deal_cards(n)
    cards = []
    n.times { cards << take_card }
    cards
  end

  def cards_left
    puts "Cards in deck: #{@deck.size}"
  end

  private

  def create_deck
    suits = %w(♣ ♠ ♥ ♦)
    #faces = %w(2 3 4 5 6 7 8 9 10 J Q K A)
    faces = ['2 ', '3 ', '4 ', '5 ', '6 ', '7 ', '8 ', '9 ', '10', 'J ', 'Q ', 'K ', 'A '] #так удобнее для вывода
    suits.each do |suit|
      faces.each do |face|
        (@deck ||= []) << { suit => face }
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

# Deck class
class Deck

  attr_accessor :deck
  
  def initialize
    create_desk    
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

end


deck = Deck.new
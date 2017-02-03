# Player class
class Player

  attr_accessor :name
  attr_accessor :balance
  attr_accessor :cards
  attr_accessor :score

  def initialize
    @balance = 100
    @name ||= ''
    @score ||= 0
    @cards = []
  end



end
require_relative 'player'

# Diller clas
class Diller < Player
  include Print

  def initialize
    super
    @name = 'Diller'
  end

end
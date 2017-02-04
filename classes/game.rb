# Game class
require_relative 'deck'
require_relative 'human'
require_relative 'dealler'
require_relative 'print'

class Game
  include Print     

  attr_accessor :bank

  def initialize
    @human = Human.new
    @human.set_name
    @dealler = Diller.new
  end



  def start_game
    unless (@human.balance || @dealler.balance) > 10
      puts "Players haven't enough money!"
      exit
    end      
    @deck = Deck.new
    @bank = 0
    @human.get_cards(@deck.deal_cards(2))
    @human.calculate_score
    @bank += @human.bet
     
    @dealler.get_cards(@deck.deal_cards(2))
    @dealler.calculate_score
    @bank += @dealler.bet
    
    print_header(@human.name)
    print_two_cards(@human.cards, @dealler.cards, true)

    print_info(@human.score, @human.balance)
    @deck.cards_left
    print_bank
  end


  def show_menu
    puts "\nMenu:"
    puts "1. Add card."
    puts "2. Skip move."
    puts "3. Open  cards."
    puts 'Enter \'stop\' for exit.'
  end


  def input
    print "\nEnter your choice number: "
    input = gets.chomp
    return input if input.to_i < 4
    wrong_input
  end


  def input_processing(value)
    stop?(value)
    case value.to_i
    when 1
      human_move
      dealler_move
      game_results
      new_game
    when 2
      dealler_move
      game_results
      new_game
    when 3
      open
      game_results
      new_game
    end
  end


  def stop?(input)
    exit if input.to_s == 'stop'
  end

  def wrong_input
    puts "\nWrong input!"
  end
end

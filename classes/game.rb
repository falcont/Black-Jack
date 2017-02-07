require_relative 'deck'
require_relative 'human'
require_relative 'dealer'
require_relative '../modules/print'

# Game class
class Game
  include Print     

  attr_accessor :bank

  def initialize
    print_logo
    @human = Human.new
    @human.set_name
    @dealer = Dealer.new
  end

  def start_game
    unless (@human.balance || @dealer.balance) > 10
      puts "Players haven't enough money!"
      exit
    end      
    @deck = Deck.new
    @bank = 0
    @human.get_cards(@deck.deal_cards(2))
    @human.calculate_score
    @bank += @human.bet
     
    @dealer.get_cards(@deck.deal_cards(2))
    @dealer.calculate_score
    @bank += @dealer.bet
    
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, true)

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

  def process_turn
    stop?(input)
    case input.to_i
    when 1
      human_move
      dealer_move
      game_results
      new_game
    when 2
      dealer_move
      game_results
      new_game
    when 3
      open
      game_results
      new_game
    end
  end

  private

  def dealer_move
    print "\nDealer is moving...\n"
    sleep(1)
    if @dealer.score < 18
      print_header(@human.name)
      @dealer.get_cards(@deck.deal_cards(1))
      @dealer.calculate_score
      print_two_cards(@human.cards, @dealer.cards, true)
      print_one_card(@human.cards[2], @dealer.cards[2], false)
      print_info(@human.score, @human.balance)
      @deck.cards_left
      print_bank
    else
      print_two_cards(@human.cards, @dealer.cards, true)
      print_one_card(@human.cards[2], @dealer.cards[2], true)
      print_info(@human.score, @human.balance)
      @deck.cards_left
      print_bank
    end
  end

  def open
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, false)
    print_all_info(@human.score, @human.balance, @dealer.score, @dealer.balance)
    @deck.cards_left
    print_bank
  end

  def human_move
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, true)
    @human.get_cards(@deck.deal_cards(1))
    @human.calculate_score
    print_one_card(@human.cards[2], nil, true)   
    print_info(@human.score, @human.balance)
    @deck.cards_left
    print_bank
  end

  def game_results
    print "\n\t\t     Game results:\n"

    if (@human.score > 21) && (@dealer.score > 21)
      draw
    elsif (@human.score > 21) && (@dealer.score < 21)
      win(@dealer)
    elsif (@human.score < 21) && (@dealer.score > 21)
      win(@human)
    else
      if @human.score == @dealer.score
        draw
      elsif @human.score > @dealer.score
        win(@human)
      elsif @human.score < @dealer.score
        win(@dealer)
      end
    end
    print_all_info(@human.score, @human.balance, @dealer.score, @dealer.balance)
    @deck.cards_left
    print_bank
  end

  def print_bank
    puts "Bank: #{@bank}"
  end

  def win(player)
    puts "\t\t! ! ! #{player.name.capitalize} WINS ! ! !"
    player.balance += bank
    @bank = 0
  end

  def draw
    puts "\t\t\t! ! ! D R A W ! ! !"
    @human.balance += @bank/2
    @dealer.balance += @bank/2
    @bank = 0
  end

  def new_game
    puts "\nStart new game? (y/n)"
    if gets.chomp == 'y'
      @human.score = 0
      @human.cards = []
      @dealer.score = 0
      @dealer.cards = []
      start_game
    else
      exit
    end
  end

  def wrong_input
    puts "\nWrong input!"
  end

  def stop?(input)
    exit if input.to_s == 'stop'
  end

end

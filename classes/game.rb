require_relative 'deck'
require_relative 'human'
require_relative 'dealer'
require_relative '../modules/print'
require 'highline'

# Game class
class Game
  include Print     

  attr_accessor :bank

  def initialize
    print_logo
    @human = new_player
    @dealer = Dealer.new
    
  end

  def start_game
    exit unless can_start_game?
    reset_game! 

    @deck = Deck.new
    
    make_bet
    get_cards
    calculate_score
    
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, hide_dealer: true)

    print_info(@human.score, @human.balance)
    print_cards_left(@deck.deck)
    print_bank(@bank)
  end

  def show_menu
    puts <<-MENU
        
    MENU:
1. Add card.
2. Skip move.
3. Open cards.
Enter \'stop\' for exit.
    MENU

  end

  def input
    @cli = HighLine.new
    @cli.ask("\nEnter your choice number: ") { |q| q.in = ['1', '2', '3', 'stop'] }
  end

  def process_turn
    value = input
    exit if stop_game?(value)
    case value.to_i
    when 1
      human_move
      dealer_move
      game_results
      new_game
    when 2
      dealer_move
      human_move if take_one_card?
      game_results
      new_game
    when 3
      open_cards
      game_results
      new_game
    end
  end

  private

  def can_start_game?
    if (@human.balance || @dealer.balance) < 11
      puts "Players haven't enough money!" 
      false
    end
    true
  end


  def make_bet
    @bank = 0
    @bank += @human.bet
    @bank += @dealer.bet
  end

  def get_cards
    @human.cards = @deck.deal_cards(2)
    @dealer.cards = @deck.deal_cards(2)
  end

  def calculate_score
    @human.calculate_score
    @dealer.calculate_score
  end

  def new_player
    print "Enter your name: "
    name = gets.chomp
    unless name == '' || nil
      Player.new(name: name) unless name == ''
    else
      wrong_input
      new_player
    end
  end

  def dealer_move
    print "\nDealer is moving...\n"
    sleep(rand(1..3))
    if @dealer.score < 18
      print_header(@human.name)
      @dealer.cards = @deck.deal_cards(1)
      @dealer.calculate_score
      print_two_cards(@human.cards, @dealer.cards, hide_dealer: true)
      print_one_card(@human.cards[2], @dealer.cards[2], hide_dealer: true)
    else
      print_two_cards(@human.cards, @dealer.cards, hide_dealer: true)
      print_one_card(@human.cards[2], @dealer.cards[2], hide_dealer: false)
    end
    print_info(@human.score, @human.balance)
    print_cards_left(@deck.deck)
    print_bank(@bank)
  end


  def open_cards
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, hide_dealer: false)
    print_all_info(@human.score, @human.balance, @dealer.score, @dealer.balance)
    print_cards_left(@deck.deck)
    print_bank(@bank)
  end

  def human_move
    print_header(@human.name)
    print_two_cards(@human.cards, @dealer.cards, hide_dealer: true)
    @human.cards = @deck.deal_cards(1)
    @human.calculate_score
    print_one_card(@human.cards[2], nil, hide_dealer: false)   
    print_info(@human.score, @human.balance)
    print_cards_left(@deck.deck)
    print_bank(@bank)
  end

  def take_one_card? #хотел использовать тут highline, но не получилось, поэтому пока как есть
    puts "\nOne more card? (y/n)"
    if gets.chomp == 'y'
      true 
    else
      false
    end
  end


  def game_results
    print "\n\t\t     Game results:\n"
    if @human.score > 21
      win(@dealer)
    elsif @human.score > 21 && @dealer.score > 21
      win(@dealer)
    elsif human_wins?
      win(@human)
    elsif @human.score == @dealer.score
      draw
    else
      win(@dealer)
    end

    print_all_info(@human.score, @human.balance, @dealer.score, @dealer.balance)
    print_cards_left(@deck.deck)
    print_bank(@bank)
  end


  def human_wins?
    (@human.score < 21 && @dealer.score > 21) || (@human.score > @dealer.score)
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
      start_game
    else
      exit
    end
  end

  def reset_game!
    @human.score = 0
    @human.cards.clear # .clear работает, а "= []" нет
    @dealer.score = 0
    @dealer.cards.clear
  end

  def stop_game?(input)
    input.to_s == 'stop'
  end

end

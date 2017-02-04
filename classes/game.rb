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


  def dealler_move
    print "\nDealer is moving...\n"
    sleep(1)
    if @dealler.score < 18
      print_header(@human.name)
      @dealler.get_cards(@deck.deal_cards(1))
      @dealler.calculate_score
      print_two_cards(@human.cards, @dealler.cards, true)
      print_one_card(@human.cards[2], @dealler.cards[2], false)
      print_info(@human.score, @human.balance)
      @deck.cards_left
      print_bank
    else
      print_two_cards(@human.cards, @dealler.cards, true)
      print_one_card(@human.cards[2], @dealler.cards[2], true)
      print_info(@human.score, @human.balance)
      @deck.cards_left
      print_bank
    end
  end

  def open
    print_header(@human.name)
    print_two_cards(@human.cards, @dealler.cards, false)
    print_all_info(@human.score, @human.balance, @dealler.score, @dealler.balance)
    @deck.cards_left
    print_bank
  end


  def human_move
    print_header(@human.name)
    print_two_cards(@human.cards, @dealler.cards, true)
    @human.get_cards(@deck.deal_cards(1))
    @human.calculate_score
    print_one_card(@human.cards[2], nil, true)   
    print_info(@human.score, @human.balance)
    @deck.cards_left
    print_bank
  end


  def game_results
    print "\n\t\tGame results:\n"
    print_all_info(@human.score, @human.balance, @dealler.score, @dealler.balance)
    @deck.cards_left
    print_bank
    if (@human.score > 21) && (@dealler.score > 21)
      draw
    elsif (@human.score > 21) && (@dealler.score < 21)
      win(@dealler)
    elsif (@human.score < 21) && (@dealler.score > 21)
      win(@human)
    else
      if @human.score == @dealler.score
        draw
      elsif @human.score > @dealler.score
        win(@human)
      elsif @human.score < @dealler.score
        win(@dealler)
      end
    end
  end

  def print_bank
    puts "Bank: #{@bank}"
  end

  def win(player)
    puts "\t\t! ! ! #{player.name.capitalize} WINS ! ! !"
    player.balance += bank
  end

  def draw
    puts "\t\t! ! ! D R A W ! ! !"
    @human.balance += @bank/2
    @dealler.balance += @bank/2
  end

  def new_game
    puts "\nStart new game? (y/n)"
    if gets.chomp == 'y'
      @human.score = 0
      @human.cards = []
      @dealler.score = 0
      @dealler.cards = []
      start_game
    else
      exit
    end
  end

  def stop?(input)
    exit if input.to_s == 'stop'
  end

  def wrong_input
    puts "\nWrong input!"
  end
end

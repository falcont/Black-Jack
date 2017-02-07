# Print module
module Print

  def print_logo
    print "\t ____  _            _     _            _     \n"\
      "\t| __ )| | __ _  ___| | __(_) __ _  ___| | __ \n"\
      "\t|  _ \\| |/ _` |/ __| |/ /| |/ _` |/ __| |/ / \n"\
      "\t| |_) | | (_| | (__|   < | | (_| | (__|   <  \n"\
      "\t|____/|_|\\__,_|\\___|_|\\_\\/ |\\__,_|\\___|_|\\_\\ \n"\
      "\t                       |__/                  \n"
  end

  def print_header(name)
    print "\n#{name.capitalize}'s cards: \t"
    print "\t\tDealer's cards: \n"
  end

  def print_info(score, balance)
    puts "Score: #{score}"
    puts "Balance: #{balance}"
  end

  def print_all_info(human_score, human_balance, dealer_score, dealer_balance)
    puts "Score: #{human_score}\t\t\tDealer score: #{dealer_score}"
    puts "Balance: #{human_balance}\t\t\tDealer balance: #{dealer_balance}"
  end

  def print_two_cards(player_cards, dealer_cards, hide_dealer: false)
    #player_cards_array ||= []
    player_cards_array = cards_to_array(player_cards) || [] # это нормальная конструкция?
    dealer_cards_array = cards_to_array(dealer_cards) || []
    if hide_dealer
      
      print "+-------+  +-------+\t\t+-------+  +-------+\n"\
            "|#{player_cards_array[1]}     |  |#{player_cards_array[3]}     |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|       |  |       |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|   #{player_cards_array[0]}   |  |   #{player_cards_array[2]}   |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|       |  |       |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|     #{player_cards_array[1]}|  |     #{player_cards_array[3]}|\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "+-------+  +-------+\t\t+-------+  +-------+\n\n"
    elsif hide_dealer == false
      #dealer_cards_array ||= []
      
      print "+-------+  +-------+\t\t+-------+  +-------+\n"\
                "|#{player_cards_array[1]}     |  |#{player_cards_array[3]}     |\t\t|#{dealer_cards_array[1]}     |  |#{dealer_cards_array[3]}     |\n"\
                "|       |  |       |\t\t|       |  |       |\n"\
                "|   #{player_cards_array[0]}   |  |   #{player_cards_array[2]}   |\t\t|   #{dealer_cards_array[0]}   |  |   #{dealer_cards_array[2]}   |\n"\
                "|       |  |       |\t\t|       |  |       |\n"\
                "|     #{player_cards_array[1]}|  |     #{player_cards_array[3]}|\t\t|     #{dealer_cards_array[1]}|  |     #{dealer_cards_array[3]}|\n"\
                "+-------+  +-------+\t\t+-------+  +-------+\n\n"
    end
  end

  def print_one_card(player_card, dealer_card, open)
    if player_card
      player_card_array ||= []
      player_card.each do |k, v| 
        player_card_array << k
        player_card_array << v
      end
    end

    if dealer_card
      dealer_card_array ||= []
      dealer_card.each do |k, v| 
        dealer_card_array << k
        dealer_card_array << v
      end
    end

    if (player_card && dealer_card && open == false)     
      print "\t+-------+\t\t\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\t\t\t|XXXXXXX|\n"\
            "\t|       |\t\t\t|XXXXXXX|\n"\
            "\t|   #{player_card_array[0]}   |\t\t\t|XXXXXXX|\n"\
            "\t|       |\t\t\t|XXXXXXX|\n"\
            "\t|     #{player_card_array[1]}|\t\t\t|XXXXXXX|\n"\
            "\t+-------+\t\t\t+-------+\n"
    elsif player_card && !dealer_card && open == true
      print "\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\n"\
            "\t|       |\n"\
            "\t|   #{player_card_array[0]}   |\n"\
            "\t|       |\n"\
            "\t|     #{player_card_array[1]}|\n"\
            "\t+-------+\n"
    elsif (!player_card && dealer_card && open == false)
      print "\t\t\t\t\t+-------+\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t+-------+\n"

    elsif (player_card && dealer_card && open == true)
      print "\t+-------+\t\t\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\t\t\t|#{dealer_card_array[1]}     |\n"\
            "\t|       |\t\t\t|       |\n"\
            "\t|   #{player_card_array[0]}   |\t\t\t|   #{dealer_card_array[0]}   |\n"\
            "\t|       |\t\t\t|       |\n"\
            "\t|     #{player_card_array[1]}|\t\t\t|     #{dealer_card_array[1]}|\n"\
            "\t+-------+\t\t\t+-------+\n"
    elsif (!player_card && dealer_card && open == true)
      print "\t\t\t\t\t+-------+\n"\
            "\t\t\t\t\t|#{dealer_card_array[1]}     |\n"\
            "\t\t\t\t\t|       |\n"\
            "\t\t\t\t\t|   #{dealer_card_array[0]}   |\n"\
            "\t\t\t\t\t|       |\n"\
            "\t\t\t\t\t|     #{dealer_card_array[1]}|\n"\
            "\t\t\t\t\t+-------+\n"           
    end
  end


  def print_cards_left(deck)
    puts "Cards in deck: #{deck.size}"
  end

  private

  def cards_to_array(cards)
    cards_array ||= []
    cards.each do |card|
      card.each do |k, v| 
        cards_array << k
        cards_array << v
      end
    end
    cards_array
  end
end

# Print module
module Print

  def print_header(name)
    print "\n#{name.capitalize}'s cards: \t"
    print "\t\tDealler's cards: \n"
  end


  def print_info(score, balance)
    puts "Score: #{score}"
    puts "Balance: #{balance}"
  end

  def print_all_info(human_score, human_balance, dealer_score, dealer_balance)
    puts "Score: #{human_score}\t\t\tDealer score: #{dealer_score}"
    puts "Balance: #{human_balance}\t\t\tDealer balance: #{dealer_balance}"
  end


  def print_two_cards(player_cards, dealler_cards, hide_dealler)
    #player_cards_array ||= []
    player_cards_array = cards_to_array(player_cards) || []
    dealler_cards_array = cards_to_array(dealler_cards) || []
    if hide_dealler == true
      
      print "+-------+  +-------+\t\t+-------+  +-------+\n"\
            "|#{player_cards_array[1]}     |  |#{player_cards_array[3]}     |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|       |  |       |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|   #{player_cards_array[0]}   |  |   #{player_cards_array[2]}   |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|       |  |       |\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "|     #{player_cards_array[1]}|  |     #{player_cards_array[3]}|\t\t|XXXXXXX|  |XXXXXXX|\n"\
            "+-------+  +-------+\t\t+-------+  +-------+\n\n"
    elsif hide_dealler == false
      #dealler_cards_array ||= []
      
      print "+-------+  +-------+\t\t+-------+  +-------+\n"\
                "|#{player_cards_array[1]}     |  |#{player_cards_array[3]}     |\t\t|#{dealler_cards_array[1]}     |  |#{dealler_cards_array[3]}     |\n"\
                "|       |  |       |\t\t|       |  |       |\n"\
                "|   #{player_cards_array[0]}   |  |   #{player_cards_array[2]}   |\t\t|   #{dealler_cards_array[0]}   |  |   #{dealler_cards_array[2]}   |\n"\
                "|       |  |       |\t\t|       |  |       |\n"\
                "|     #{player_cards_array[1]}|  |     #{player_cards_array[3]}|\t\t|     #{dealler_cards_array[1]}|  |     #{dealler_cards_array[3]}|\n"\
                "+-------+  +-------+\t\t+-------+  +-------+\n\n"
    end
  end


  def print_one_card(player_card, dealler_card, open)
    if player_card
      player_card_array ||= []
      player_card.each do |k, v| 
        player_card_array << k
        player_card_array << v
      end
    end

    if dealler_card
      dealler_card_array ||= []
      dealler_card.each do |k, v| 
        dealler_card_array << k
        dealler_card_array << v
      end
    end

    if (player_card && dealler_card && open == false)     
      print "\t+-------+\t\t\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\t\t\t|XXXXXXX|\n"\
            "\t|       |\t\t\t|XXXXXXX|\n"\
            "\t|   #{player_card_array[0]}   |\t\t\t|XXXXXXX|\n"\
            "\t|       |\t\t\t|XXXXXXX|\n"\
            "\t|     #{player_card_array[1]}|\t\t\t|XXXXXXX|\n"\
            "\t+-------+\t\t\t+-------+\n"
    elsif player_card && !dealler_card && open == true
      print "\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\n"\
            "\t|       |\n"\
            "\t|   #{player_card_array[0]}   |\n"\
            "\t|       |\n"\
            "\t|     #{player_card_array[1]}|\n"\
            "\t+-------+\n"
    elsif (!player_card && dealler_card && open == false)
      print "\t\t\t\t\t+-------+\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t|XXXXXXX|\n"\
            "\t\t\t\t\t+-------+\n"

    elsif (player_card && dealler_card && open == true)
      print "\t+-------+\t\t\t+-------+\n"\
            "\t|#{player_card_array[1]}     |\t\t\t|#{dealler_card_array[1]}     |\n"\
            "\t|       |\t\t\t|       |\n"\
            "\t|   #{player_card_array[0]}   |\t\t\t|   #{dealler_card_array[0]}   |\n"\
            "\t|       |\t\t\t|       |\n"\
            "\t|     #{player_card_array[1]}|\t\t\t|     #{dealler_card_array[1]}|\n"\
            "\t+-------+\t\t\t+-------+\n"
    elsif (!player_card && dealler_card && open == true)
      print "\t\t\t\t\t+-------+\n"\
            "\t\t\t\t\t|#{dealler_card_array[1]}     |\n"\
            "\t\t\t\t\t|       |\n"\
            "\t\t\t\t\t|   #{dealler_card_array[0]}   |\n"\
            "\t\t\t\t\t|       |\n"\
            "\t\t\t\t\t|     #{dealler_card_array[1]}|\n"\
            "\t\t\t\t\t+-------+\n"           
    end
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

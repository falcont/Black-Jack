#require_relative 'deck'
#require_relative 'classes/player'
require_relative 'classes/game'

print "\t  ____  _            _     _            _     \n"\
      "\t | __ )| | __ _  ___| | __(_) __ _  ___| | __ \n"\
      "\t |  _ \\| |/ _` |/ __| |/ /| |/ _` |/ __| |/ / \n"\
      "\t | |_) | | (_| | (__|   < | | (_| | (__|   <  \n"\
      "\t |____/|_|\\__,_|\\___|_|\\_\\/ |\\__,_|\\___|_|\\_\\ \n"\
      "\t                        |__/                  \n"

game = Game.new
game.start_game
game.show_menu

loop do
  game.input_processing(game.input)
end
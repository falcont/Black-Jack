require_relative 'classes/game'

game = Game.new
game.start_game
game.show_menu

loop { game.process_turn }


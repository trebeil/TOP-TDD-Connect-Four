require_relative './game'

game = Game.new
game.welcome
game.display_board
until game.game_end?
  game.choose_column
  game.display_board
end
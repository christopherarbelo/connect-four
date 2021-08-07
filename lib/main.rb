require_relative 'connect_four'
require_relative 'player'

# Change name and marker
player_one = Player.new('name one', 'marker one')
player_two = Player.new('name two', 'marker two')

game = ConnectFour.new player_one, player_two
game.play

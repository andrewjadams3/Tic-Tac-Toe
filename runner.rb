require_relative 'ai'
require_relative 'game'

game = Game.new
ai = Ai.new

puts "Welcome to tic-tac-toe!"
puts "Make the first move"
puts game
until game.over?
  move = gets.chomp
  game.make_move(move.to_i)
  ai.make_move(game)
  puts game
end

puts "Game over!"
game.winner ? (puts "\"#{game.winner}\" wins!") : (puts "It's a draw!")
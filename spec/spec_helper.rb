#Helper functions

def flatten_board(board)
  board.flatten.map { |symbol| symbol == ' ' ? nil : symbol }
end

def test_ai(test_board)
  board = Board.new(flatten_board(test_board))
  game = Game.new(board)
  ai = Ai.new(game)
  game.current_turn = 'O'
  ai.make_move
  board
end
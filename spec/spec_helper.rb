#Helper functions

def flatten_board(board)
  board.flatten.map { |symbol| symbol == ' ' ? nil : symbol }
end
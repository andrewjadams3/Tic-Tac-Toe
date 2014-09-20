class Game
  LINES  = [[0,1,2], [3,4,5], 
            [6,7,8], [0,3,6], 
            [1,4,7], [2,5,8], 
            [0,4,8], [2,4,6]]

  def initialize(ai_symbol, player_symbol)
    @board = Array.new(9)
    @ai_symbol, @player_symbol = ai_symbol, player_symbol
    @winner = nil
  end

  def ai_move(position)
    @board[position-1] = @ai_symbol
  end

  def player_move(position)
    @board[position-1] = @player_symbol
  end

  def winner?
    !!@winner
  end

  def check_for_winner
    LINES.each do |line|
      @winner = @board[line[0]] if winning_line?(line)
    end
  end

  def winning_line?(line)
    values = line.map { |position| @board[position] }
    values.uniq.size == 1 && values[0] != nil
  end
end

game = Game.new('X', 'O')
game.player_move(1)
game.ai_move(2)
game.player_move(3)
game.check_for_winner
puts game.winner?
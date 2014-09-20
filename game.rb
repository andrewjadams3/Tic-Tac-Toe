class Game
  LINES  = [[0,1,2], [3,4,5], 
            [6,7,8], [0,3,6], 
            [1,4,7], [2,5,8], 
            [0,4,8], [2,4,6]]

  attr_reader :ai_symbol, :player_symbol, :empty_positions, :current_turn

  def initialize(ai_symbol='O', player_symbol='X')
    @board = Array.new(9)
    @empty_positions = (0..8).to_a
    @ai_symbol, @player_symbol = ai_symbol, player_symbol
    @current_turn = player_symbol
    @winner = nil
  end

  def make_move(position, symbol) 
    @board[position] = symbol
    @empty_positions.delete(position)
  end

  def empty?
    empty_positions.size == 9
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
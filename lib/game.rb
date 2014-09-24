class Game
  LINES  = [[0,1,2], [3,4,5], 
            [6,7,8], [0,3,6], 
            [1,4,7], [2,5,8], 
            [0,4,8], [2,4,6]]

  attr_reader :ai_symbol, :player_symbol, 
              :empty_positions, :current_turn,
              :winner, :board

  def initialize
    @board = Array.new(9)
    @empty_positions = (0..8).to_a
    @ai_symbol, @player_symbol = 'O', 'X'
    @current_turn = @player_symbol
    @winner = nil
  end

  def make_move(position)
    return false unless @empty_positions.include?(position) && !over?
    @board[position] = @current_turn
    @empty_positions.delete(position)
    @current_turn = new_turn
    check_for_winner
    true
  end

  def empty?
    empty_positions.size == 9
  end

  def over?
    !!@winner || empty_positions.empty?
  end

  def ai_turn?
    @current_turn == @ai_symbol
  end

  def valid_position?(position)
    @empty_positions.include?(position)
  end

  def number_of_moves
    @board.size - @empty_positions.size
  end

  def random_corner
    [0,2,6,8].sample
  end

  def center
    4
  end

  def center_taken?
    !!@board[center]
  end

  private

  def new_turn
    @current_turn == @ai_symbol ? @player_symbol : @ai_symbol
  end

  def check_for_winner
    LINES.each do |line|
      @winner = @board[line[0]] if winning_line?(line)
    end
  end

  def winning_line?(line)
    values = line.map { |position| @board[position] }
    values.uniq.size == 1 && !values.include?(nil)
  end

  #Creates a deep copy when #dup is called on an instance of Game
  def initialize_copy(source)
    empty_positions = @empty_positions.dup
    board = @board.dup
    current_turn = @current_turn
    super
    @current_turn = current_turn
    @empty_positions = empty_positions
    @board = board
  end
end
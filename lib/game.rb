class Game
  LINES  = [[0,1,2], [3,4,5], 
            [6,7,8], [0,3,6], 
            [1,4,7], [2,5,8], 
            [0,4,8], [2,4,6]]

  attr_reader :ai_symbol, :player_symbol, 
              :current_turn, :winner, :board

  def initialize(board)
    @board = board
    @ai_symbol, @player_symbol = 'O', 'X'
    @current_turn = @player_symbol
    @winner = nil
  end

  def make_move(position)
    @board.place_piece(@current_turn, position)
    @current_turn = new_turn
    check_for_winner
  end

  def over?
    !!@winner || available_moves.empty?
  end

  def ai_turn?
    @current_turn == @ai_symbol
  end

  def valid_move?(position)
    available_moves.include?(position) && !over?
  end

  def available_moves
    @board.empty_positions
  end

  def number_of_moves
    @board.size - available_moves.size
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
    board = @board.dup
    current_turn = @current_turn
    super
    @board = board
    @current_turn = current_turn
  end
end
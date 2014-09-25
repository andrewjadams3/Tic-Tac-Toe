class Game
  attr_reader :ai_symbol, :player_symbol, 
              :current_turn, :winner, :board

  def initialize(board)
    @board = board
    @ai_symbol, @player_symbol = 'O', 'X'
    @current_turn = @player_symbol
  end

  def make_move(position)
    if valid_move?(position)
      @board.place_piece(@current_turn, position)
      @current_turn = new_turn
    end
  end

  def available_moves
    @board.empty_positions
  end

  def number_of_moves
    @board.size - available_moves.size
  end

  def winner
    @board.winning_piece
  end

  def valid_move?(position)
    available_moves.include?(position) && !over?
  end

  def over?
    !!winner || available_moves.empty?
  end

  def ai_turn?
    @current_turn == @ai_symbol
  end

  private

  def new_turn
    @current_turn == @ai_symbol ? @player_symbol : @ai_symbol
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
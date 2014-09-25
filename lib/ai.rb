class Ai
  def initialize(game)
    @game = game
    @board = game.board
    @ai_symbol = game.ai_symbol
    @player_symbol = game.player_symbol
  end

  def make_move
    @game.make_move(best_move)
  end

  private

  def best_move
    chosen_move = nil
    if @game.number_of_moves == 1
      chosen_move = @board.center_taken? ? @board.random_corner : @board.center
    else
      find_best_choice(@game)
      chosen_move = @best_choice
    end
    chosen_move
  end

  def find_best_choice(game)
    return score(game) if game.over?
    moves = try_moves(game)

    if game.current_turn == @ai_symbol
      max_score = moves.max_by{|position, score| score}
      @best_choice = max_score.first
      return max_score.last
    else
      min_score = moves.min_by{|position, score| score}
      @best_choice = min_score.first
      return min_score.last
    end
  end

  def try_moves(game)
    moves = Hash.new
    game.available_moves.each do |position|
      test_game = game.dup
      test_game.make_move(position)
      moves[position] = find_best_choice(test_game)
    end
    moves
  end

  WIN  =  1
  LOSE = -1
  TIE  =  0

  def score(game)
    if game.winner == @ai_symbol
      WIN
    elsif game.winner == @player_symbol
      LOSE
    else
      TIE
    end 
  end
end
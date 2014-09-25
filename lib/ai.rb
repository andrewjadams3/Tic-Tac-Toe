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
      predict_move(@game)
      chosen_move = @best_choice
    end
    chosen_move
  end

  def predict_move(game)
    return score(game) if game.over?
    moves = Hash.new

    game.available_moves.each do |position|
      test_game = game.dup
      test_game.make_move(position)
      moves[position] = predict_move(test_game)
    end

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
class Ai

  def make_move(game)
    @game = game
    @symbol = game.ai_symbol
    game.make_move(best_move)
  end

  def best_move
    return random_corner if @game.empty?
    if @game.number_of_moves <= 1
      @game.center_taken? ? (return @game.random_corner) : (return @game.center)
    else
      predict_move
      @best_choice
    end
  end
end
class View
  INSULTS = [
    "I once owned a dog that was smarter then you.",
    "You make me want to puke.",
    "You play like a dairy farmer.",
    "Have you stopped wearing diapers yet?",
    "I've heard you were a contemptible sneak.",
    "You're no match for my brains, you poor fool.",
    "There are no words for how disgusting you are.",
    "You are a pain in the backside, sir!",
    "There are no clever moves that can help you now.",
    "I'm not going to take your insolence sitting down!",
    "I usually see people like you passed-out on tavern floors."
  ]

  BOARD = <<BOARD

 X | X | X 
-----------
 X | X | X 
-----------
 X | X | X 

BOARD

  def initialize(game)
    @game = game
    @position = 0
    @current_insult = INSULTS.sample
    @board = BOARD
  end

  def draw_screen
    [draw_board, status_line, position_line, instructions].join("\n")
  end

  def move(x,y)
    x = (@position + x) % 3
    y = ((@position / 3) + y) % 3
    @position = x + (y * 3)
  end

  def set
    if @game.make_move(@position)
      @current_insult = INSULTS.sample
      true
    else
      @current_insult = "Are you kidding me? You can't play there!"
      false
    end
  end

  private

  def draw_board
    index = -1
    @board.gsub(" X ") do
      index += 1
      field = @game.board[index] ? @game.board[index] : " "
      @position == index ? "(#{field})" : " #{field} "
    end
  end

  def instructions
    "Q = Quit  | Return = Play\nR = Reset | Arrow Keys = Move"
  end

  def position_line
    "Position: #{@position + 1}"
  end

  def status_line
    if @game.winner
      "'#{@game.winner}' wins! Press 'R' to reset."
    elsif @game.over?
      "It's a draw... Press 'R' to reset."
    elsif @game.number_of_moves == 0
      "Let's play!"
    else
      @current_insult
    end
  end
end
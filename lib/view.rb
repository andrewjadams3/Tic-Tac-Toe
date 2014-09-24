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

  STATUSES = {
    start: "Let's play!",
    draw: "It's a draw... Press 'R' to reset.",
    win: " wins! Press 'R' to reset.",
    bad_move: "Are you kidding me? You can't play there!"
  }

  INSTRUCTIONS = "Q = Quit  | Return = Play\nR = Reset | Arrow Keys = Move"

  BOARD = <<BOARD

   |   |   
-----------
   |   |   
-----------
   |   |   

BOARD

  def initialize(game)
    @game = game
    @position = 0
    @status = update_status
    @board = BOARD
  end

  def draw_screen
    update_status
    [draw_board, @status, INSTRUCTIONS].join("\n")
  end

  def move_cursor(x,y)
    x = (@position + x) % 3
    y = ((@position / 3) + y) % 3
    @position = x + (y * 3)
  end

  def attempt_position
    if @game.valid_position?(@position)
      set_position
      @current_insult = INSULTS.sample
    else
      @current_insult = STATUSES[:bad_move]
    end
  end

  private

  def set_position
    @game.make_move(@position)
  end

  def draw_board
    index = -1
    @board.gsub("   ") do
      index += 1
      field = @game.board[index] ? @game.board[index] : " "
      @position == index ? "(#{field})" : " #{field} "
    end
  end

  def update_status
    if @game.winner
      @status = "'#{@game.winner}'" + STATUSES[:win]
    elsif @game.over?
      @status = STATUSES[:draw]
    elsif @game.number_of_moves == 0
      @status = STATUSES[:start]
    else
      @status = @current_insult
    end
  end
end
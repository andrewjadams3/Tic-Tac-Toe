class View
  def initialize(game)
    @game = game
    @position = 0
    @board = <<BOARD

 X | X | X 
-----------
 X | X | X 
-----------
 X | X | X 

BOARD
  end

  def draw_board
    index = -1
    @board.gsub(" X ") do
      index += 1
      field = @game.board[index] ? @game.board[index] : " "
      @position == index ? "[#{field}]" : " #{field} "
    end
  end

  def draw_screen
    [draw_board, status_line, position_line, "Q = Quit | R = Reset | Return = Play"].join("\n")
  end

  def move(x,y)
    x = (@position + x) % 3
    y = ((@position / 3) + y) % 3
    @position = x + (y * 3)
  end

  def set
    @game.make_move(@position)
  end

  def position_line
    "Position: #{@position + 1}"
  end

  def status_line
    if @game.winner
      "'#{@game.winner}' wins! Press 'R' to reset."
    elsif @game.over?
      "It's a draw... Press 'R' to reset."
    else
      "Let's play!"
    end
  end
end
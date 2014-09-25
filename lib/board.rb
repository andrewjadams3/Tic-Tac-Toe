class Board
  def initialize(board_array=nil)
    @board_array = board_array || Array.new(9)
    @empty_positions = (0..8).to_a
  end

  def empty?
    empty_positions.size == 9
  end

  def place_piece(piece, position)
    @board_array[position] = piece
    @empty_positions.delete(position)
  end

  def random_corner
    [0,2,6,8].sample
  end

  def center
    4
  end

  def center_taken?
    !!@board_array[center]
  end
end
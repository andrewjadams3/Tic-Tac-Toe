class Board
  LINES  = [[0,1,2], [3,4,5], 
            [6,7,8], [0,3,6], 
            [1,4,7], [2,5,8], 
            [0,4,8], [2,4,6]]

  attr_reader :empty_positions, :winning_piece

  def initialize(board_array=nil)
    @board_array = board_array || Array.new(9)
    @winning_piece = nil
    set_empty_positions
    find_winning_piece
  end

  def place_piece(piece, position)
    if @board_array[position].nil?
      @board_array[position] = piece
      set_empty_positions
      find_winning_piece
    end
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

  def empty?
    empty_positions.size == 9
  end

  def size
    @board_array.size
  end

  def [](position)
    @board_array[position]
  end

  private

  def find_winning_piece
    LINES.each do |line|
      @winning_piece = @board_array[line[0]] if winning_line?(line)
    end
  end

  def winning_line?(line)
    values = line.map { |position| @board_array[position] }
    values.uniq.size == 1 && !values.include?(nil)
  end

  def set_empty_positions
    @empty_positions = (0..8).select { |position| @board_array[position].nil? }
  end

  def initialize_copy(source)
    board_array = @board_array.dup
    empty_positions = @empty_positions.dup
    super
    @board_array = board_array
    @empty_positions = empty_positions
  end
end
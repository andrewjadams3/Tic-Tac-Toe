require 'rspec'
require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/view'

describe View do
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

  let(:game){ Game.new(Board.new) }
  let(:view){ View.new(game) }

  context 'starting a new game' do
    it 'should display a starting status' do
      expect(view.draw_screen).to include STATUSES[:start]
    end

    it 'should display instructions' do
      expect(view.draw_screen).to include INSTRUCTIONS
    end

    it 'should display a board' do
      expect(view.draw_screen).to include(board = <<BOARD
( )|   |   
-----------
   |   |   
-----------
   |   |   

BOARD
        )
    end

    it 'should initialize the cursor to the first position' do
      expect(view.position).to eq 0
    end
  end

  context 'moving the cursor' do
    before(:each) { view.move_cursor(1,0) }

    it 'should update the cursor position' do
      expect(view.position).to eq 1
    end

    it 'should display the cursor in the new position' do
      expect(view.draw_screen).to include(board = <<BOARD
   |( )|   
-----------
   |   |   
-----------
   |   |   

BOARD
        )
    end
  end

  context 'attempting a move' do
    before(:each) { view.attempt_position }

    it 'should update the status to an insult after a successful move' do
      expect(INSULTS).to include view.status
    end

    it 'should update the status to bad move after an unsucessful move' do
      view.attempt_position
      expect(view.status).to eq STATUSES[:bad_move]
    end

    it 'should display a piece in the proper position after a move' do
      expect(view.draw_screen).to include(board = <<BOARD
(X)|   |   
-----------
   |   |   
-----------
   |   |   

BOARD
        )
    end
  end

  context 'winning a game' do
    it 'should display a winning status' do
      win_board = [['O', 'X', 'X'],
                   ['X', 'O', ' '],
                   [' ', ' ', 'O']]
      board = Board.new(flatten_board(win_board))
      game = Game.new(board)
      view = View.new(game)
      expect(view.draw_screen).to include STATUSES[:win]
    end
  end

  context 'drawing a game' do
    it 'should display a draw status' do
      draw_board = [['O', 'X', 'X'],
                    ['X', 'O', 'O'],
                    ['X', 'O', 'X']]
      board = Board.new(flatten_board(draw_board))
      game = Game.new(board)
      view = View.new(game)
      expect(view.draw_screen).to include STATUSES[:draw]
    end
  end
end
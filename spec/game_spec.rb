require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  let(:board) { Board.new }
  let(:game) { Game.new(board) }

  context 'new game' do
    it 'should set ai and player symbols' do 
      expect(game.ai_symbol).to eq 'O'
      expect(game.player_symbol).to eq 'X'
    end

    it 'should allow the player to go first' do
      expect(game.current_turn).to eq 'X'
    end

    it 'should not be the ais turn' do
      expect(game.ai_turn?).to be false
    end

    it 'should not have a winner' do
      expect(game.winner).to be nil
    end

    it 'should not be over' do
      expect(game.over?).to be false
    end

    it 'should not have any moves' do
      expect(game.number_of_moves).to eq 0
    end
  end

  context 'making a move' do
    before(:each) { game.make_move(4) }

    it 'should allow a piece to be played in an open spot' do
      expect(game.board[4]).to eq 'X'
    end

    it 'should not allow a piece to be played in a taken spot' do
      game.make_move(4)
      expect(game.board[4]).to eq 'X'
    end

    it 'should alternate between players' do
      expect(game.ai_turn?).to be true
    end

    it 'should increase the number of moves' do
      expect(game.number_of_moves).to eq 1
    end
  end

  context 'determining a winner' do
    before(:all) do
      winning_board = [['O', 'X', ' '],
                       [' ', 'X', 'O'],
                       [' ', 'X', ' ']]
      board = Board.new(flatten_board(winning_board))
      @winning_game = Game.new(board)
    end

    it 'should declare the correct winner' do
      expect(@winning_game.winner).to eq 'X'
    end

    it 'should be over' do
      expect(@winning_game.over?).to be true
    end
  end

  context 'determining a draw' do
    before(:all) do
      draw_board = [['O', 'X', 'X'],
                    ['X', 'O', 'O'],
                    ['X', 'O', 'X']]
      board = Board.new(flatten_board(draw_board))
      @draw = Game.new(board)
    end

    it 'should not declare a winner' do
      expect(@draw.winner).to eq nil
    end

    it 'should be over' do
      expect(@draw.over?).to be true
    end

    it 'should not have any remaining available moves' do
      expect(@draw.available_moves.empty?).to be true
    end
  end
end
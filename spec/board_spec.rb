require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/board'

describe Board do
  CORNERS = [0,2,6,8]
  let(:board) { Board.new }

  context 'blank board' do
    it 'should have all empty positions' do
      expect(board.empty?).to be true
    end

    it 'should not have a winning piece' do
      expect(board.winning_piece).to be nil
    end
  end

  context 'placing a piece' do
    it 'should place a piece in an empty position' do
      board.place_piece('O', 1)
      expect(board[1]).to eq 'O'
    end

    it 'should not place a piece in a taken position' do
      board.place_piece('O', 1)
      board.place_piece('X', 1)
      expect(board[1]).to eq 'O'
    end

    it 'should update empty positions' do
      board.place_piece('O', 1)
      expect(board.empty_positions).to_not include 1
    end
  end

  context 'extra board methods' do
    it 'should return a random corner' do
      expect(CORNERS).to include board.random_corner
    end

    it 'should return the center' do
      expect(board.center).to be 4
    end

    it 'should indicate whether the center has been taken' do
      expect(board.center_taken?).to be false
      board.place_piece('X', 4)
      expect(board.center_taken?).to be true
    end

    it 'should return the size of the board' do
      expect(board.size).to be 9
    end

    it 'should return the appropriate piece when brackets are used' do
      expect(board[4]).to be nil
      board.place_piece('X', 4)
      expect(board[4]).to eq 'X'
    end
  end

  context 'determining a winner' do
    before(:all) do
      winning_board = [['O', 'X', ' '],
                       [' ', 'X', 'O'],
                       [' ', 'X', ' ']]
      @winning_board = Board.new(flatten_board(winning_board))
    end

    it 'should indicate a winning piece' do
      expect(@winning_board.winning_piece).to eq 'X'
    end

    it 'should indicate the correct empty positions' do
      expect(@winning_board.empty_positions).to eq [2,3,6,8]
    end
  end
end
require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/ai'

describe Ai do
  CORNERS = [0,2,6,8]

  describe 'the first move' do

    it 'should take the center space when available' do
      test_board = [['X', ' ', ' '],
                    [' ', ' ', ' '],
                    [' ', ' ', ' ']]            
      board = test_ai(test_board)
      expect(board[4]).to eq 'O'
    end

    it 'should take a corner when the center is taken' do
      test_board = [[' ', ' ', ' '],
                    [' ', 'X', ' '],
                    [' ', ' ', ' ']]            
      board = test_ai(test_board)
      corners = CORNERS.select { |corner| board[corner] == 'O' }
      expect(corners).to_not be_empty
    end
  end
end 
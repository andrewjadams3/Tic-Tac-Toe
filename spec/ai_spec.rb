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
      taken_corner = CORNERS.select { |corner| board[corner] == 'O' }
      expect(taken_corner).to_not be_empty
    end
  end

  describe 'blocking' do
    it 'should prevent a player from winning' do
      test_board = [['X', ' ', ' '],
                    ['X', 'O', ' '],
                    [' ', ' ', ' ']]            
      board = test_ai(test_board)
      expect(board[6]).to eq 'O'
    end
  end

  describe 'winning' do
    it 'should take a winning move when possible' do
      test_board = [['X', ' ', ' '],
                    ['X', 'O', ' '],
                    ['O', 'X', ' ']]            
      board = test_ai(test_board)
      expect(board[2]).to eq 'O'
    end
  end

  describe 'edge cases' do
    it 'should force a block when a player takes opposite corners' do
      test_board = [['X', ' ', ' '],
                    [' ', 'O', ' '],
                    [' ', ' ', 'X']]            
      board = test_ai(test_board)
      expect(board[1]).to eq 'O'
    end

    it 'should force a block when a player takes a corner and an edge' do
      test_board = [['X', ' ', ' '],
                    [' ', 'O', ' '],
                    [' ', 'X', ' ']]            
      board = test_ai(test_board)
      expect(board[3]).to eq 'O'
    end

    it 'should take a corner when a player takes two edges' do
      test_board = [[' ', 'X', ' '],
                    ['X', 'O', ' '],
                    [' ', ' ', ' ']]            
      board = test_ai(test_board)
      expect(board[0]).to eq 'O'
    end
  end
end 
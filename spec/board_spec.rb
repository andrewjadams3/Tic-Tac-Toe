require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/board'

describe Board do
  let(:board) { Board.new }

  context 'blank board' do
    it 'should have all empty positions' do
      expect(board.empty_positions).to eq (0..8).to_a
    end

    it 'should not have a winning piece' do
      expect(board.winning_piece).to be nil
    end
  end
end
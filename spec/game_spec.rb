require 'rspec'
require_relative '../game'

describe Game do

  describe 'new game' do
    let(:game) { Game.new }

    it 'should have an empty board' do
      expect(game.empty?).to be true
    end

    it 'should set ai and player symbols' do 
      expect(game.ai_symbol).to eq 'O'
      expect(game.player_symbol).to eq 'X'
    end

    it 'should allow the player to go first' do
      expect(game.current_turn).to eq 'X'
    end

    it 'should not have a winner' do
      expect(game.winner).to be nil
    end

  end

end
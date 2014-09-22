require 'rspec'
require_relative '../lib/game'

describe Game do
  let(:game) { Game.new }

  context 'new game' do
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

    it 'should not be over' do
      expect(game.over?).to be false
    end
  end

  context 'making a move' do
    it 'should allow a piece to be played in an open spot' do
      expect(game.make_move(4)).to be true
    end

    it 'should not allow a piece to be played in a taken spot' do
      game.make_move(4)
      expect(game.make_move(4)).to be false
      expect(game.board[4]).to eq 'X'
    end

    it 'should alternate between players' do
      game.make_move(4)
      game.make_move(5)
      expect(game.board[4]).to eq 'X'
      expect(game.board[5]).to eq 'O'
    end

    it 'should indicate if the center spot is taken' do
      expect(game.center_taken?).to be false
      game.make_move(4)
      expect(game.center_taken?).to be true
    end
  end

  context 'determining a winner' do
    before(:all) do
      @winning_game = Game.new
      @winning_game.make_move(0) #X
      @winning_game.make_move(3) #O
      @winning_game.make_move(1) #X
      @winning_game.make_move(4) #O
      @winning_game.make_move(2) #X
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
      @draw = Game.new
      @draw.make_move(0) #X
      @draw.make_move(1) #O
      @draw.make_move(2) #X
      @draw.make_move(4) #O
      @draw.make_move(3) #X
      @draw.make_move(6) #O
      @draw.make_move(5) #X
      @draw.make_move(8) #O
      @draw.make_move(7) #X
    end

    it 'should not declare a winner' do
      expect(@draw.winner).to eq nil
    end

    it 'should be over' do
      expect(@draw.over?).to be true
    end

    it 'should not have any remaining empty positions' do
      expect(@draw.empty_positions.empty?).to be true
    end
  end
end
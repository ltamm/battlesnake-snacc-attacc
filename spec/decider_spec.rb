# frozen_string_literal: true

require 'decider'
require_relative '../battlesnake_server.rb'

describe Decider do
  describe 'decide' do
    context 'if up is clear' do
      it 'returns move up' do
        test_snake = BattleSnake::Snake.new 'name', 100, [ { 'x' => 0, 'y' => 1 } ]
        board = BattleSnake::Board.new 3, 1, [], { 'test_id': test_snake }
        @decider = Decider.new(board, 'test_id')
        expect(@decider.decide).to eq('up')
      end
    end
    context 'if down is clear (and up is not)' do
      it 'returns move down' do
        test_snake = BattleSnake::Snake.new 'name', 100, [ { 'x' => 0, 'y' => 0 } ]
        board = BattleSnake::Board.new 3, 1, [], { 'test_id': test_snake }
        @decider = Decider.new(board, 'test_id')
        expect(@decider.decide).to eq('down')
      end
    end
    context 'if left is clear (and up and down are not)' do
      it 'returns move left' do
        test_snake = BattleSnake::Snake.new 'name', 100, [ { 'x' => 1, 'y' => 0 } ]
        board = BattleSnake::Board.new 1, 3, [], { 'test_id': test_snake }
        @decider = Decider.new(board, 'test_id')
        expect(@decider.decide).to eq('left')
      end
    end
    context 'if right is clear (and nothing else is)' do
      it 'returns move right' do
        test_snake = BattleSnake::Snake.new 'name', 100, [ { 'x' => 0, 'y' => 0 } ]
        board = BattleSnake::Board.new 1, 3, [], { 'test_id': test_snake }
        @decider = Decider.new(board, 'test_id')
        expect(@decider.decide).to eq('right')
      end
    end
  end
end

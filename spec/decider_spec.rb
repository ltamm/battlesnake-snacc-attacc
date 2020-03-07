# frozen_string_literal: true

require 'decider'
require_relative '../battlesnake_server.rb'

describe Decider do
  describe 'decide' do
    before(:each) do
      board = double('BattleSnake::Board')
      @decider = Decider.new(board, 'test_id')
    end
    context 'if no direction is clear' do
      it 'returns move up' do
      end
    end
    context 'if down is clear' do
      it 'returns move down' do
      end
    end
    context 'if left is clear' do
      it 'returns move left' do
      end
    end
    context 'if right is clear' do
      it 'returns move right' do
      end
    end
  end
end

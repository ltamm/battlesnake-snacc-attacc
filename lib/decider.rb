# frozen_string_literal: true

# The engine for deciding where snake goes next
class Decider
  DIRECTIONS = %i[up down left right].freeze
  attr_reader :board, :player_id

  def initialize(board, player_id)
    @board = board
    @player_id = player_id
  end

  def clear_path?(direction)
    # blockages include out of bound array indices of board
    # and snake bodies
    puts "TODO: check for blockages in direction: #{direction}"
    true
  end

  def decide
    return 'down' if clear_path? :down

    # DIRECTIONS.each do |direction|
    #   return direction.to_s if clear_path? direction
    # end

    # if for some sad reason no direction is clear, it is game over
    # and we nobly (and arbitrarily) go up
    'up'
  end
end

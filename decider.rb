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
    # blockages checked:
    #   - out of bound array indices of board
    head = board.snakes[player_id].body[0].body_segment_to_coordinate
    case direction
    when :up
      next_coordinate = Coordinate.new head['x'], head['y'] - 1
    when :right
      next_coordinate = Coordinate.new head['x'] + 1, head['y']
    when :left
      next_coordinate = Coordinate.new head['x'] - 1, head['y']
    when :down
      next_coordinate = Coordinate.new head['x'], head['y'] - 1
    end
    !(out_of_bounds? next_coordinate)
  end

  def body_segment_to_coordinate(segment)
    Coordinate.new segment['x'], segment['y']
  end

  def out_of_bounds?(coordinate)
    coordinate.x.negative?        ||
      coordinate.x >= board.width ||
      coordiante.y.negative?      ||
      coordinate.y >= board.height
  end

  def decide
    DIRECTIONS.each do |direction|
      return direction.to_s if clear_path? direction
    end

    # if for some sad reason no direction is clear, it is game over
    # and we arbitrarily go up :(
    'up'
  end

  Coordinate = new Struct(:x, :y)
end

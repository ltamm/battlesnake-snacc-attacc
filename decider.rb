# frozen_string_literal: true

# The engine for deciding where snake goes next
class Decider
  attr_reader :board, :player_id, :blockers

  def initialize(board, player_id, direction_priority = nil)
    @board = board
    @player_id = player_id
    @blockers = []
    @direction_priority = direction_priority
    board.snakes.each do |_id, snake|
      snake.body.each do |segment|
        blockers.push body_segment_to_coordinate segment
      end
    end
  end

  def direction_priority
    @direction_priority || set_direction_priority
  end

  def set_direction_priority
    current = current_coordinate
    scores = { current: calculate_score(current) }
    %i[up down left right].each do |d|
      next_location = next_coordinate(d, current)
      scores[d] = calculate_score(next_location)
    end
    order = []
    scores.sort_by { |_, v| v }.each do |pair|
      order.append(pair[0]) unless pair[0] == :current
    end
    order
  end

  def calculate_score(location)
    # score comprises the amount of food - amount of blockers
    food_score(location) - blocker_score(location)
  end

  def food_score(location)
    score = 0
    board.food.each do |f|
      food_location = body_segment_to_coordinate f
      score += location.distance_from(food_location)
    end
    score
  end

  def blocker_score(location)
    score = 0
    blockers.each do |b|
      score += location.distance_from(b)
    end
    score
  end

  def clear_path?(direction)
    # blockages checked:
    #   - out of bound array indices of board
    head_coordinate = current_coordinate
    destination = next_coordinate(direction, head_coordinate)
    !(out_of_bounds?(destination) || blocked?(destination))
  end

  def player_snake
    board.snakes[player_id]
  end

  def current_coordinate
    head = player_snake.body[0]
    body_segment_to_coordinate head
  end

  def next_coordinate(direction, current)
    case direction
    when :up
      Coordinate.new current['x'], current['y'] - 1
    when :down
      Coordinate.new current['x'], current['y'] + 1
    when :left
      Coordinate.new current['x'] - 1, current['y']
    when :right
      Coordinate.new current['x'] + 1, current['y']
    end
  end

  def body_segment_to_coordinate(segment)
    Coordinate.new segment['x'], segment['y']
  end

  def out_of_bounds?(coordinate)
    coordinate.x.negative?          ||
      coordinate.x == board.width   ||
      coordinate.y.negative?        ||
      coordinate.y == board.height
  end

  def blocked?(coordinate)
    blockers.include? coordinate
  end

  def decide

    puts direction_priority

    direction_priority.each do |direction|
      return direction.to_s if clear_path? direction
    end

    # if for some sad reason no direction is clear, it is game over
    # and we arbitrarily go up :(
    'up'
  end

  Coordinate = Struct.new(:x, :y) do
    def distance_from(coordinate)
      dist_x = (coordinate.x - x)**2
      dist_y = (coordinate.y - y)**2
      Math.sqrt(dist_x + dist_y)
    end
  end
end

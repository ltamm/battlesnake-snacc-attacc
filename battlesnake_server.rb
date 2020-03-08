# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

require_relative 'lib/decider.rb'

# Main class for handling Battlesnake API
class BattleSnake < Sinatra::Base
  get '/' do
    '🐍'
  end

  post '/ping' do
  end

  post '/start' do
    palette = ['#e4d1d1', '#b9b0b0', '#d9ecd0', '#77a8a8']

    json color: palette[rand(3)],
         headType: 'beluga',
         tailType: 'round-bum'
  end

  post '/move' do
    data = JSON.parse request.body.read
    board = data['board']
    my_id = data['you']['id']

    snakes = {}
    board['snakes'].each do |s|
      snakes[s['id']] = Snake.new(s['name'], s['health'], s['body'])
    end

    decider = Decider.new(
      Board.new(board['height'],
                board['width'],
                board['food'],
                snakes),
      my_id
    )

    json move: decider.decide!,
         shout: 'Leeeeeeeeeeeeeroy'
  end

  post '/end' do
  end

  Board = Struct.new(:height, :width, :food, :snakes)
  Snake = Struct.new(:name, :health, :body)
end

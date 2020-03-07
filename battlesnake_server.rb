# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'

require_relative 'decider.rb'

# Main class for handling Battlesnake API
class BattleSnake < Sinatra::Base
  get '/' do
    '🐍'
  end

  post '/ping' do
  end

  post '/start' do
    json color: '#ffc0cb',
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
    
    json move: decider.decide,
         shout: 'Test snake please ignore'
  end

  post '/end' do
  end

  Board = Struct.new(:height, :width, :food, :snakes)
  Snake = Struct.new(:name, :health, :body)
end

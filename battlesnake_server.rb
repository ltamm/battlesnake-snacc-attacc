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
    game = gamify! data

    decider = Decider.new game

    json move: decider.decide!,
         shout: 'Leeeeeeeeeeeeeroy'
  end

  post '/end' do
  end

  def gamify!(data)
    board = boardify! data['board']
    Game.new board, data['you']['id']
  end

  def boardify!(board_data)
    snakes = {}
    board_data['snakes'].each do |s|
      snakes[s['id']] = Snake.new(s['name'], s['health'], s['body'])
    end
    Board.new(board_data['height'],
      board_data['width'],
      board_data['food'],
      snakes)
    end

  Game = Struct.new(:board, :player_id)
  Board = Struct.new(:height, :width, :food, :snakes)
  Snake = Struct.new(:name, :health, :body)
end

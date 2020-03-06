require 'sinatra/base'
require 'sinatra/json'

require_relative 'decider.rb'

class BattleSnake < Sinatra::Base

    get '/' do
        "SNACCATTACC"
    end

    post '/ping' do
    end

    post '/start' do
        json :color => '#ffc0cb', 
             :headType => 'beluga', 
             :tailType => 'round-bum'
    end

    post '/move' do

        data = JSON.parse request.body.read
        board = data["board"]
        me = data["you"]

        player_snake = Snake.new me["id"],
                                 me["name"],
                                 me["health"],
                                 me["body"]
        decider = Decider.new(
            Board.new(board["height"], 
                      board["width"], 
                      board["food"],
                      board["snakes"]),
            player_snake
        )
        
        json :move => decider.decide,
             :shout => "Test snake please ignore" 
    end

    post '/end' do
    end

    Board = Struct.new(:height, :width, :food, :snakes) do
    end
    Snake = Struct.new(:id, :name, :health, :body)
end


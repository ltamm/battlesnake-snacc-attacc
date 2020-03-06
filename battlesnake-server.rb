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

        @data = JSON.parse request.body.read
        decider = Decider.new(
            Board.new @data["board"]["height"], @data["board"]["width"]
        )
        

        json :move => decider.decide,
             :shout => "Test snake please ignore" 
    end

    post '/end' do
    end

    Board = Struct.new(:height, :width) do
    end
end


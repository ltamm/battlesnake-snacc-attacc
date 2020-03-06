require 'sinatra/base'
require 'sinatra/json'

class BattleSnake < Sinatra::Base

    attr_accessor :data

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



        json :move => "up",
             :shout => "Test snake please ignore" 
    end

    post '/end' do
    end
end


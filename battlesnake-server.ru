require 'sinatra/base'
require 'sinatra/json'

class BattleSnake < Sinatra::Base

    attr_accessor :game

    get '/' do
        "SNACCATTACC"
    end

    post '/ping' do
    end

    post '/start' do
        json :color => 'white', 
             :headType => 'beluga', 
             :tailType => 'round-bum'
    end

    post '/move' do
        json :move => "up",
             :shout => "Test snake please ignore" 
    end

    post '/end' do
    end
end

run BattleSnake.run!

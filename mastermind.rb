require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require_relative './game.rb'

game = Game.new

get '/mastermind' do
  @guesses = game.guesses
  @all_feedback = game.all_feedback
  
  erb :mastermind
end

post '/mastermind' do
  game.update_board(params.values)
  @guesses = game.guesses
  @all_feedback = game.all_feedback
  
  game.turn_countdown

  if game.game_lost?
    @message = 'you lost'
    erb :mastermind
  elsif game.game_won?
    @message = 'game won'
    erb :mastermind
  else
    erb :mastermind 
  end
end
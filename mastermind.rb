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
  
  puts game.code

  @message = nil

  if game.game_lost?
    @message = 'you lost'
  elsif game.game_won?
    @message = 'game won' 
  end

  game.turn_countdown

  erb :mastermind
end
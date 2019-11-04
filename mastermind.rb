require 'sinatra'
require 'erb'
require_relative './game.rb'

game = Game.new


get '/mastermind' do
  @guesses = game.guesses
  @all_feedback = game.all_feedback
  
  erb :mastermind
end

post '/mastermind' do
  if params.values[0] == "new_game"
    game = Game.new

    @guesses = game.guesses
    @all_feedback = game.all_feedback

    erb :mastermind
  else
    game.turn_countdown

    game.update_board(params.values)
    @guesses = game.guesses
    @all_feedback = game.all_feedback
    
    puts game.code

    @message = nil

    if game.game_lost?
      @message = 'You lost'
      @solution = game.code
    elsif game.game_won?
      @message = 'You won!' 
      @solution = game.code
    end

    erb :mastermind
  end
end
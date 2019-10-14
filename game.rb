require 'set'

class Game
  def initialize
    @players = [HumanPlayer.new(self), ComputerPlayer.new(self)]
    @code_maker = 1
    @code = @players[@code_maker].get_code
    @turns_left = 10
    @guesses = Array.new(@turns_left) { Array.new(4, 'gray') }
    @all_feedback = Array.new(@turns_left) { Array.new(4, 'gray') }
  end

  attr_accessor :guesses, :all_feedback, :turns_left

  def update_board(code_guess)
    add_guess_to_guesses(code_guess)
    add_feedback_to_all_feedback(code_guess)
  end
  
  def add_guess_to_guesses(code_guess)
    @guesses[@turns_left] = code_guess
  end

  def add_feedback_to_all_feedback(params)
    feedback = feedback_on_guess(params)
    padded_feedback = feedback.fill('gray', feedback.length, 4 - feedback.length)
    
    @all_feedback[@turns_left] = padded_feedback
  end

  def feedback_on_guess(code_guess)
    code_duplicate = @code.dup
    feedback = []

    code_duplicate.map.with_index do |entry, i|
      if entry == code_guess[i]
        feedback.push('red')
        code_guess[i] = -1
        -2
      else
      entry
      end
    end.each do |entry|
      found_index = code_guess.find_index(entry)
      if found_index
        feedback.push('black')
        code_guess[found_index] = -1
      end
    end

    feedback
  end

  def turn_countdown
    @turns_left -= 1
  end

  def game_won?(feedback)
    guess_feedback[guess.length - 1] == "red"
  end

  def game_lost?
    @turn == 0
  end

  def code_breaker
    1 - @code_maker
  end
  
end

class Player
  def initialize(game)
    @game = game
  end
end

class HumanPlayer < Player
  
end
 
class ComputerPlayer < Player
  def initialize(game)
    super(game)
  end

  def get_code
    colors = ['red', 'green', 'blue', 'orange', 'pink', 'purple', 'yellow', 'white']
    Array.new(4){colors[rand(1..8)]}
  end
end


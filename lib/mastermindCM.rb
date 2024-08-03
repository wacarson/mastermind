require_relative 'gameCM'

class MastermindCM
  def start_game
    puts "Create a code for the computer to break."
    puts "Enter 4 colors in the correct sequence. Options are:"
    puts "Red, Orange, Yellow, Green, Blue, Purple"
    puts "Good Luck!\n\n"

    game = GameCM.new
    game.computer_guess
  end
end

require_relative 'gameCB'

class MastermindCB
  def start_game
    puts "Guess the computer's code."
    puts "Enter 4 colors in the correct sequence. Options are:"
    puts "Red, Orange, Yellow, Green, Blue, Purple"
    puts "You have 12 guesses. Good Luck!\n\n"

    game = GameCB.new
    i = 0
    while i < 12
      puts "Guess #{i+1}"
      begin
        guess = gets.chomp.split
      rescue Interrupt
        puts "\nGame quit. Goodbye."
        quit = true
        break
      else
       i += 1 if game.check_input(guess)
       response = game.check_answer(guess)
       break if response == 'win'
      end
      puts " "
    end

    unless quit == true
      unless response == 'win'
        puts "No more guesses. You lose!"
        puts "It was #{game.to_s}"
      end
      if response == 'win'
        puts "You cracked the code in #{i} guesses!"
      end
    end
  end
end

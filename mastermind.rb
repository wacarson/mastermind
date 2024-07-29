require_relative 'lib/game'

class Mastermind
  puts "Welcome to Mastermind. Guess the computer's code."
  puts "Enter 4 colors in the correct sequence. Options are:"
  puts "Red, Orange, Yellow, Green, Blue, Purple"
  puts "You have 10 guesses. Good Luck!\n\n"

  game = Game.new
  i = 0
  while i < 10
    puts "Guess #{i+1}"
    begin
      guess = gets.chomp.split
    rescue Interrupt
      puts "\nGame quit. Goodbye."
	  quit = true
      break
    else
     i += 1 if game.check_input(guess)
     break if game.check_answer(guess) == 'win'
    end
    puts " "
  end

  if i == 10
    puts "No more guesses. You lose!"
    puts "It was #{game.code}"
  elsif quit
    a = 'b'
  else
    puts "You cracked the code in #{i} guesses!"
  end
end

Mastermind.new()

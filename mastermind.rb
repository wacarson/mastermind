require_relative 'lib/mastermindCB'
require_relative 'lib/mastermindCM'

class Mastermind
  puts "Welcome to Mastermind. Enter 0 to crack the computer's code. Enter 1 to have the computer crack your code. Q to quit."

  mode = gets.chomp
  until mode == '0' or mode == '1' or mode.upcase == 'q'
    puts "Invalid entry. Enter 0 to crack a code or 1 to make a code."
    mode = gets.chomp
  end

  MastermindCB.new().start_game if mode == '0'
  MastermindCM.new().start_game if mode == '1'

end

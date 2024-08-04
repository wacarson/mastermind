require_relative 'checker'
require_relative 'guess'

class GameCM
  attr_reader :code
  def initialize
    @code = make_code
    @checker = Checker.new()
    @guess = Guess.new()
  end

  def make_code
    valid = false
    until valid == true
      begin
         colors = gets.chomp.upcase.split
      rescue Interrupt
        puts "\nGame quit. Goodbye."
        break
      else
       valid = true if check_input(colors)
      end
    end
    
    colors.map {|color| color[0]} unless colors == nil
  end

  def check_input(colors)
     result = false
     cell_check = []
     colors.each do |c|
       cell_check.push(true) if c == 'R' or c == 'O' or c == 'Y'
       cell_check.push(true) if c == 'G' or c == 'B' or c == 'P'
     end
     result = true if cell_check.length == 4
     puts "Bad input. Enter 4 colors separated by spaces." unless result
     result
  end

  def computer_guess
    return if @code == nil
    colors = {"Red"=> 0, "Orange"=> 0, "Yellow"=> 0,
				 "Green"=> 0, "Blue"=> 0, "Purple"=> 0}
    for i in 1..12
      guess = []
      finds = 0
      colors.each {|k, v| finds += v }
      i = 6 if finds == 4 && i < 7
        case i
          when 1 then guess = ["Red", "Red", "Red", "Red"]
          when 2 then guess = ["Orange", "Orange", "Orange", "Orange"]
          when 3 then guess = ["Yellow", "Yellow", "Yellow", "Yellow"]
          when 4 then guess = ["Green", "Green", "Green", "Green"]
          when 5 then guess = ["Blue", "Blue", "Blue", "Blue"]
          when 6
            colors["Purple"] = 4 - finds
            guess = @guess.guess_smart(colors)
        else
          guess = @guess.best_guess(colors)
        end
      puts guess[0] + " " + guess[1] + " " + guess[2] + " " + guess[3]
      response = check_answer(guess.map {|color| color[0]})
      colors[guess[0]] = response if i < 6
      puts " "
      break if response == 'win'
    end
    puts "Computer wins! Cracked in #{i} tries." if response == 'win'
    puts "You win! The computer did not crack the code" unless response == 'win'
  end


  def check_answer(guess)
     return 'win' if guess.join == @code.join
     @guess.exact_locations = @checker.check_exacts(guess, @code)
     @guess.wrong_locations = @checker.check_colors(guess, @guess.exact_locations, @code)
     @guess.total_locations
  end

  def to_s
    @code[0] + " " + @code[1] + " " + @code[2] + " " + @code[3]
  end
  
end

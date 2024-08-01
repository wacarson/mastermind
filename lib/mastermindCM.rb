#require_relative 'gameCM'

class GameCM
  attr_reader :code
  def initialize
    @code = make_code
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
      i = 7 if finds == 4 && i < 7
        case i
          when 1 then guess = ["Red", "Red", "Red", "Red"]
          when 2 then guess = ["Orange", "Orange", "Orange", "Orange"]
          when 3 then guess = ["Yellow", "Yellow", "Yellow", "Yellow"]
          when 4 then guess = ["Green", "Green", "Green", "Green"]
          when 5 then guess = ["Blue", "Blue", "Blue", "Blue"]
          when 6
            colors["Purple"] = 4 - finds
            guess = guess_smart(colors)
        else
          guess = guess_smart(colors)
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

  def guess_smart(colors)
    code_colors = []
    colors.each do |color, value|
      for i in 1..value
        code_colors.push(color)
      end
    end
    return code_colors.shuffle
  end

  def check_answer(guess)
     return 'win' if guess.join == @code.join
     locations = check_exacts(guess)
     wrong_locations = check_colors(guess, locations)
     return locations.length + wrong_locations
  end

  def check_exacts(guess)
     count = 0
     locations = []
     i = 0
     guess.each do
       if guess[i].upcase == @code[i]
         count += 1
         locations.push(i)
       end
       i += 1
     end
    puts "#{count} exactly correct"
    return locations.reverse
  end

  def check_colors(guesses, exact_locations)
    temp_code = @code.clone
    exact_locations.each do | loc |
      temp_code.delete_at(loc)
      guesses.delete_at(loc)
    end
    
    count = 0
    guesses.uniq.each do |guess|
      count += 1 if temp_code.include?(guess.upcase)
    end
    puts "#{count} in the wrong location"
    return count
  end

  def to_s
    @code[0] + " " + @code[1] + " " + @code[2] + " " + @code[3]
  end
  
end


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

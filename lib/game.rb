class Game
  attr_reader :code
  def initialize
    @code = make_code
  end

  def make_code
    new_code = []
    for i in 1..4
      j = rand(6)
      case j
        when 0 then new_code.push("R")
        when 1 then new_code.push("O")
        when 2 then new_code.push("Y")
        when 3 then new_code.push("G")
        when 4 then new_code.push("B")
        when 5 then new_code.push("P")
      end
    end
    new_code
  end

  def check_input(guess)
     result = false
     result = true if guess.length == 4
     guess.each do |color|
       c = color.upcase
       result = true if c[0] == 'R' or c[0] == 'O' or c[0] == 'Y'
       result = true if c[0] == 'G' or c[0] == 'B' or c[0] == 'P'
     end
     puts "Bad input. Enter 4 colors separated by spaces." unless result
     result
  end

  def check_answer(guess)
     return 'win' if guess.join.upcase == @code.join
     locations = check_exacts(guess)
     check_colors(guess, locations)
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
  end
end #close class

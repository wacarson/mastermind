class Checker
  def check_exacts(guess, code)
     count = 0
     locations = []
     i = 0
     guess.each do
       if guess[i].upcase == code[i]
         count += 1
         locations.push(i)
       end
       i += 1
     end
    puts "#{count} exactly correct"
    return locations.reverse
  end

  def check_colors(guesses, exact_locations, code)
    temp_code = code.clone
    exact_locations.each do | loc |
      temp_code.delete_at(loc)
      guesses.delete_at(loc)
    end
    
    count = 0
    guesses.each do |guess|
      count += 1 if temp_code.include?(guess.upcase)
    end
    puts "#{count} in the wrong location"
    return count
  end
  
end

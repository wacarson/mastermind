require_relative 'checker'

class GameCB
  attr_reader :code
  def initialize
    @code = make_code
    @checker = Checker.new()
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
     locations = @checker.check_exacts(guess, code)
     @checker.check_colors(guess, locations, code)
  end

  def to_s
    @code[0] + " " + @code[1] + " " + @code[2] + " " + @code[3]
  end
  
end

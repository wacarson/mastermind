class Guess
  attr_accessor :guess, :exact_locations, :wrong_locations, :previous_guess
  attr_accessor :total_locations
  def initialize
    @guess = []
    @exact_locations = []
    @wrong_locations = 0
    @total_locations = 0
    @previous_guess = []
    @hit2 = false
    @iteration = 1
  end

  def guess_smart(colors)
    code_colors = []
    colors.each do |color, value|
      for i in 1..value
        code_colors.push(color)
      end
    end
    @previous_guess = code_colors
    @guess = code_colors.shuffle
  end

  def total_locations
    @exact_locations.length + @wrong_locations
  end

  def best_guess(colors)
    case exact_locations.length
      when 0
        @previous_guess.push(@previous_guess[0])
        @previous_guess.shift
        @guess = @previous_guess
      when 1
        if @hit2
          shift_array
        else
          last = @guess.pop()
          last2nd = @guess.pop()
          @guess.push(last)
          @guess.push(last2nd)
        end
      when 2
		@hit2 = true
        shift_array
    end
  end

  def shift_array
    temp_guess = @previous_guess.clone
    case @iteration
      when 1
        last = temp_guess.pop()
        last2nd = temp_guess.pop()
        temp_guess.push(last)
        temp_guess.push(last2nd)
      when 2
        first = temp_guess.shift()
        second = temp_guess.shift()
        temp_guess.unshift(first)
        temp_guess.unshift(second)
      when 3
        first = temp_guess.shift()
        last = temp_guess.pop()
        temp_guess.reverse!
        temp_guess.unshift(first)
        temp_guess.push(last)
      when 4
        first = temp_guess.shift()
        last = temp_guess.pop()
        temp_guess.unshift(last)
        temp_guess.push(first)
      when 5
        first = temp_guess.shift()
        second = temp_guess.shift()
        temp_guess.reverse!
        temp_guess.unshift(first)
        temp_guess.push(second)
      when 6
        last = temp_guess.pop()
        last2nd = temp_guess.pop()
        temp_guess.reverse!
        temp_guess.push(last)
        temp_guess.unshift(last2nd)
    end
    @iteration += 1
    @guess = temp_guess
  end

end

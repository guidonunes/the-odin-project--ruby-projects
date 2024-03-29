class Mastermind
  COLORS = ["R", "G", "B", "Y", "O", "P", "W"].freeze
  
  attr_accessor :player_guess
  
  def initialize
    game_instructions
    @secret_code = self.secret_code
    @first_play = true # track if it's the first play
  end

  def game_instructions
    puts "==================== Welcome to Mastermind! ===================="
    puts " "
    puts "In this game, you will try to guess the secret code." 
    puts "The secret code is a combination of 4 (four) colors."
    puts "The Available colors are: R, G, B, Y, O, P, W. (Red, Green, Blue, Yellow, Orange, Purple, White)"
    puts " "
    puts " "
    puts "After each guess, you will receive feedback."
    puts " "
    puts "  - ●  means correct color in the correct position."
    puts "  - ○  means correct color but in the wrong position."
    puts "  - _  means incorrect color."
    puts " "
    puts "You have 10 attempts to crack the code. Have fun!"
    puts " "
    puts "=================================================================="
  end

  def secret_code
    COLORS.shuffle.take(4)
  end
  
  def player_guess
    # show message only on the first play
    if @first_play
      puts "Please, enter a sequence of 4 (four) colors (e.g., 'RGBY'). Available colors: R, G, B, Y, O, P, W. (Red, Green, Blue, Yellow, Orange, Purple, White)"
      @first_play = false # set first_play to false after first play
    end

      loop do
      input = gets.chomp.upcase
      if valid_input?(input)
        return stringfy_guess(input)
      else
        puts "Invalid input. Please enter a sequence of valid colors."
      end  
    end
  end

  def valid_input?(input)
    input.match?(/\A[RGBYOPW]{4}\z/)
  end

  def stringfy_guess(guess)
    guess.upcase.split('')
  end 

  def evaluate_guess(secret_code, player_guess)
    feedback = []

    player_guess.each_with_index do |color, index|
      if color == secret_code[index]
        feedback << '●'  # correct color in correct position
      elsif secret_code.include?(color)
        feedback << '○'  # correct color but in the wrong position 
      else
        feedback << '_' # incorrect color    
      end
    end
    feedback        
  end

  def total_attempts
    loop do
      secret_code = self.secret_code
      make_attempts(secret_code)
      break unless play_again
    end
  end

  def make_attempts(secret_code)
    @current_attempt = 0
    10.times do |i|
      current_attempt = i
      puts ''
      puts "<<< This guessing number #{i + 1} out of 10 >>>"
      puts ''
      current_guess = player_guess
      feedback = evaluate_guess(secret_code, current_guess)
      puts "Feedback: #{feedback.join(' ')}"

      if winning_combo?(feedback)
        puts "Congratulations! You won!"
        return
      end
    end
  end
  
  def winning_combo?(feedback)
    feedback.all? {|symbol| symbol == '●'}
  end

  def play_again
    puts "Want to play again? (y/n)"
    answer = gets.chomp.downcase
    answer == 'y'
  end

end


#game setup
mastermind = Mastermind.new
loop do
  secret_code = mastermind.secret_code
  mastermind.total_attempts

  break unless mastermind.play_again
end




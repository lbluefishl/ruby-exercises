class Mastermind

  def initialize
    @player_score = 0
    @computer_score = 0
    @rounds = 0
    @game_rounds = 1
    @game_rounds_max = 0
    @colors = ["b", "g", "o", "p", "r", "y"]
    @current_breaker = ""
    @weighted_colors = ["b","g","o","p","r","y"]
  end

  def intro
    print "Welcome to Mastermind!\nDo you know the rules of the game?\ny/n: "  
    @rules = gets.chomp
    print "please enter lowercase y or n (yes or no)" unless @rules == "y" || @rules == "n"
    rules if @rules == "n"
    start_game
  end

  def rules
    print "In Mastermind, you take the role of the codemaker or the codebreaker. The code is a sequence of four colors.\n"
    sleep 5
    print "The possible colors are blue, green, orange, purple, red, and yellow. The colors can be used multiple times or not at all.\n"
    sleep 5
    print "Since we will be guessing quite a bit, use the first letter of each color. For example, a good guess would be bygg for blue, yellow, green, green.\n"
    sleep 5
    print "Try to guess the following code:\n"
    print "_ _ _ _\n"
    @good_guess = gets.chomp.gsub(" ","").split("")
    good_code?(@good_guess)
    print "Nice guess! Your first guess may be incorrect, but keep trying!\n"
    sleep 4
    print "You get up to 12 guesses. If you guess correctly, your total score will increase by the number of tries it took for you to guess the code. You want to have the LEAST number of points at the end of the game to win.\n"
    sleep 8
    print "Even if you did not guess correctly, you will get feedback based on how you did.\n"
    sleep 4
    print "You will be told the number of colors you guessed correctly and whether or not they are in the correct position.\n"
    sleep 4
    print "Enough chat! Let's play.\n\n"
    sleep 3
    start_game
  end

  def good_code?(code)
    if code.select{|e| e == "b" || e == "g" || e == "o" || e == "p" || e == "r" || e == "y"}.length == 4 
      return
    else  
      print "Invalid code. Use only the first letter of each color, such as bopr (for blue, orange, purple, red.\n"
      if code_breaker == "Player"
        @user_code = gets.chomp.gsub(" ","").split("")
        good_code?(@user_code)
      else
        @random_code = gets.chomp.gsub(" ","").split("")
        good_code?(@random_code)
      end
    end
  end

  def generate_rounds
    @game_rounds_max = gets.chomp.to_i
    unless (@game_rounds_max % 2 == 0) && (2..10).include?(@game_rounds_max)
      print "Please enter an even number from 2 to 10.\n"
      generate_rounds
    end 
  end

  def start_game
    print "How many rounds would you like to play? (enter an even number up to 10) \n"
    generate_rounds
    print "Do you wish to start as the codemaker or the codebreaker?\n"
    print "enter cm/cb: "
    @player_choice = gets.chomp
    unless @player_choice == "cm" || @player_choice == "cb"
      print "Invalid selection. Please type \"cm\" for codemaker or \"cb\" for codebreaker.\n"
      print "enter cm/cb: "
      @player_choice = gets.chomp
    end
    if @player_choice == "cm"
      codemaker
      @current_breaker = "Computer"
    end
    if @player_choice == "cb"
      codebreaker 
      @current_breaker = "Player"
    end
  end

  def codemaker
    @current_breaker = "Computer"
    print "Generate your secret code.\n"
    @random_code = gets.chomp.gsub(" ","").split("")
    good_code?(@random_code)
    first_three_tries
    computer_guess
  end

  def computer_guess
    @rounds += 1
    sleep 1
    print "The computer is making a calculated guess...\n"
    sleep 5
    generate_guess
    check_guess
    update_colors
    end_round if @rounds == 12
    computer_guess
  end

  def first_three_tries
    @rounds += 1
    sleep 2
    print "\n\nThe computer is making a calculated guess...\n"
    sleep 3

    @user_code = ["b","b","g","g"]
    print @user_code.join("") + "\n"
    check_guess
    @correct_spots = @correct_colors + @correct_positions
    if @correct_spots == 4
      @weighted_colors = ["b","b","g","g"]
      shuffle_positions
    elsif @correct_spots == 3
      3.times {@weighted_colors.push("b")}
      3.times {@weighted_colors.push("g")}
    elsif @correct_spots == 2
      2.times {@weighted_colors.push("b")}
      2.times {@weighted_colors.push("g")}
    elsif @correct_spots == 1
      1.times {@weighted_colors.push("b")}
      1.times {@weighted_colors.push("g")}
    else 
      @weighted_colors.delete("b")
      @weighted_colors.delete("g")
    end

    @rounds += 1
    sleep 2
    print "The computer is making a calculated guess...\n"
    sleep 3

    @user_code = ["r","r","o","o"]
    print @user_code.join("") + "\n"
    check_guess
    @correct_spots = @correct_colors + @correct_positions
    if @correct_spots == 4
      @weighted_colors = ["r","r","o","o"]
      shuffle_positions
    elsif @correct_spots == 3
      3.times {@weighted_colors.push("r")}
      3.times {@weighted_colors.push("o")}
    elsif @correct_spots == 2
      2.times {@weighted_colors.push("r")}
      2.times {@weighted_colors.push("o")}
    elsif @correct_spots == 1
      1.times {@weighted_colors.push("r")}
      1.times {@weighted_colors.push("o")}
    else
      @weighted_colors.delete("r")
      @weighted_colors.delete("o")
    end

    @rounds += 1
    sleep 2
    print "The computer is making a calculated guess...\n"
    sleep 3

    @user_code = ["p","p","y","y"]
    print @user_code.join("") + "\n"
    check_guess
    @correct_spots = @correct_colors + @correct_positions
    if @correct_spots == 4
      @weighted_colors = ["p","p","y","y"]
      shuffle_positions
    elsif @correct_spots == 3
      3.times {@weighted_colors.push("p")}
      3.times {@weighted_colors.push("y")}
    elsif @correct_spots == 2
      2.times {@weighted_colors.push("p")}
      2.times {@weighted_colors.push("y")}
    elsif @correct_spots == 1
      1.times {@weighted_colors.push("p")}
      1.times {@weighted_colors.push("y")}
    else
      @weighted_colors.delete("p")
      @weighted_colors.delete("y")
    end

  end

  def generate_guess  
    @user_code = []
    4.times{@user_code.push(@weighted_colors.sample)}
    print @user_code.join("") + "\n"
  end

  def shuffle_positions
    @used = {}
    @rounds += 1
    sleep 1
    print "The computer is making a calculated guess...\n"
    sleep 5
    @user_code = @user_code.shuffle 
    print @user_code.join("") + "\n"
    check_guess
    end_round if @rounds == 12
    shuffle_positions
  end


  def update_colors
    @correct_spots = @correct_colors + @correct_positions
    if @correct_spots == 4
      shuffle_positions
    elsif @correct_spots == 3
      3.times {@weighted_colors += @user_code}
    elsif @correct_spots == 2
      2.times {@weighted_colors += @user_code}
    elsif @correct_spots == 1
      @weighted_colors += @user_code
    else 
      @weighted_colors -= @user_code
    end
  end

  def codebreaker
    get_random_code
    @current_breaker = "Player"
    print "\nRound #{@game_rounds}.\nThe computer has created a code.\n"
    print "_ _ _ _\n"
    print "What's the code?\n"
    game_rounds
  end

  def game_rounds
    @rounds += 1
    @user_code = gets.chomp.gsub(" ","").split("")
    good_code?(@user_code)
    check_guess
    end_round if @rounds == 12
    game_rounds
  end

  def get_random_code
    @random_code = []
    4.times{@random_code.push(@colors.sample)}
  end

  def check_guess
    @correct_colors = 0
    @correct_positions = 0
    winner if @user_code == @random_code  
    print "Incorrect Code.\n"
    @code_copy = @random_code.map(&:clone)
    @user_copy = @user_code.map(&:clone)
    i = 0
    4.times do      
      if @random_code[i] == @user_code[i]
        @correct_positions += 1 
        @code_copy[i] = 0
        @user_copy[i] = 1
      end
      i += 1 
    end
    @user_copy.each { |e| 
    if @code_copy.include?(e) 
      @correct_colors += 1 
      @code_copy.delete_at(@code_copy.index(e))
    end

  }
  print "Color(s) in the right position: #{@correct_positions}.\n"
  print "Color(s) in the wrong position: #{@correct_colors}.\n\n "
  end

  def winner
    print "Correct! #{@current_breaker} wins!\n"
    print "#{@rounds} points were added to #{@current_breaker}'s total score.\n"
    if @current_breaker == "Player"
      @player_score += @rounds
      @current_breaker == "Computer" 
    else
      @computer_score += @rounds
      @current_breaker == "Player"
    end
    print "Player Score: #{@player_score}\n"
    print "Computer Score: #{@computer_score}\n"
    @game_rounds += 1
    @rounds = 0
    sleep 3
    final_score if @game_rounds > @game_rounds_max 
    if @current_breaker == "Player"
      print "Your turn to make the code!\n"
      codemaker
    else
      print "Your turn to crack the code!\n"
      codebreaker
    end
  end

  def end_round
    sleep 2
    print "All 12 guesses were incorrect.\n 12 points were added to #{@current_breaker}'s total score.\n"
    if @current_breaker == "Player"
      @player_score += 12
      @current_breaker == "Computer" 
    else
      @computer_score += 12
      @current_breaker == "Player"
    end
    print "Player Score: #{@player_score}\n"
    print "Computer Score: #{@computer_score}\n"
    @game_rounds += 1
    @rounds = 0
    sleep 3
    final_score if @game_rounds > @game_rounds_max 
    if @current_breaker == "Player"
      print "Your turn to make the code!\n"
      codemaker
    else
      print "Your turn to crack the code!\n"
      codebreaker
    end
  end

  def final_score
    sleep 2
    print "All of the rounds were completed.\n\n"
    sleep 2
    print "Final Player Score: #{@player_score}\n"
    sleep 1
    print "Final Computer Score: #{@computer_score}\n"
    sleep 1
    print @player_score < @computer_score ? "Player is the Mastermind!" : "Computer is the Mastermind!"
    exit
  end


end

game = Mastermind.new
game.intro
























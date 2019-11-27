
class Match
  @@CODE_KEY = {1 => "R", 2 => "B", 3 => "G", 4 => "Y", 5 => "W", 6 => "P"}

  attr_accessor :board, :code,:computerScore, :HumanScore, :gamesRemaining
  attr_reader :choice
  def initialize
    @board = Array.new(8, Array.new(8, '_'))
    @choice
    @code
    @winner = false
    @computerScore = 0
    @humanScore = 0
    @gamesRemaining
  end

  def play
    display_rules()
    puts
    puts "How many games would you like to play?"
    input = gets.to_i
    while (input < 0 and input % 1 != 0 )
      puts "Please input a positive integer."
      input = gets.to_i
    end

    @gamesRemaining = input * 2

    puts "There will be #{input * 2} games. One round will consist of two games for the computer and player, respectively."
    puts
    maker_or_breaker()

    while (@gamesRemaining > 0)
      clearBoard()

      if (@choice == "maker")
        maker()
        clearBoard()
        breaker()
      elsif (@choice == "breaker")
        breaker()
        clearBoard()
        maker()
      end
    end

    puts "Final Score| Human: #{@humanScore} | Computer: #{@computerScore}"
  end

  def code_generator
    code_array = []
    4.times do |i|
      code_array[i] = @@CODE_KEY[rand(1..6)]
    end

    @code = code_array
  end

  def display_board
    for i in @board
      puts "#{i[0]} #{i[1]} #{i[2]} #{i[3]} | #{i[4]}  #{i[5]}  #{i[6]}  #{i[7]}"
    end
  end

  def display_rules
    puts "*********************************************************************************"
    puts "Colors available: Red (R), Blue (B), Green (G), Yellow (Y), White (W), Purple (P)"
    puts "Exact matches will be represented by an X"
    puts "Correct color matches but not in the right place will be represented by an O"
    puts "There must be an even number of games which will be chosen by player"
    puts "Each game will have 8 rounds"
    puts "Colors CAN be repeated"
    puts "Scores will be displayed separately"
    puts "*********************************************************************************"

  end

  def maker_or_breaker
    puts "Do you want to be the codebreaker or codemaker first?"
    puts "Type M for codemaker or B for codebreaker."
    input = gets.chomp
    while (input.downcase != "m" and input.downcase != "b")
      puts "Incorrect input. Type M for codemaker or B for codebreaker."
      input = gets.chomp
    end

    if (input.downcase == 'm')
      @choice = "maker"
    else
      @choice = "breaker"
    end
  end

  def breaker()
    @gamesRemaining -= 1
    turn = 0
    code_generator()

    while (!@winner and turn < 8)
      puts
      display_board()
      puts
      guess = get_guess()
      check_winner?(guess, turn)
      turn += 1
    end

    display_board()

    if (turn == 8)
      puts
      puts "Ran out of turns!"
      puts
    end

    @computerScore += turn

    puts "Human: #{@humanScore} | Computer: #{@computerScore}"
    puts
  end

  def maker()
    @gamesRemaining -= 1
    turn = 0
    get_code()

    while (!@winner and turn < 8)
      puts
      display_board()
      puts
      guess = get_computerGuess()
      check_winner?(guess, turn)
      turn += 1
    end

    display_board()

    if (turn == 8)
      puts
      puts "Ran out of turns!"
      puts
    end

    @humanScore += turn

    puts "Human: #{@humanScore} | Computer: #{@computerScore}"
    puts
  end

  def clearBoard
    @board = Array.new(8, Array.new(8, '_'))
  end

  def check_winner?(guess, turn)
    if (guess == @code)
      puts "Correct guess!"
      @winner = true
    end

    matches = []
    guessRemaining = []
    codeRemaining = []

    for k in (0...4)
      if (guess[k] == @code[k])
        matches.push('X')
      else
        guessRemaining.push(guess[k])
        codeRemaining.push(@code[k])
      end
    end

    guessRemaining.each do |a|
      if codeRemaining.include?(a)
        matches.push('O')
        flag = false
        j = 0
        while(!flag)
          if (codeRemaining[j] == a)
            codeRemaining.delete_at(j)
            flag = true
          end
          j += 1
        end
      end
    end

    codeRemaining.length.times{matches.push('_')}

    @board[turn] = matches.concat(guess)
  end

  def get_computerGuess()
    computerGuess = []
    4.times do |i|
      computerGuess[i] = @@CODE_KEY[rand(1..6)]
    end

    computerGuess
  end

  def get_guess()
    guess = []
    for i in 1..4
      puts "Enter letter #{i} for your guess."
      input = gets.chomp

      while (input.downcase != 'r' and input.downcase != 'b' and input.downcase != 'g' and input.downcase != 'y' and             input.downcase != 'w' and input.downcase != 'p')

        puts "Invalid entry. Please enter letter #{i} for your guess."
        input = gets.chomp
      end

      guess.push(input.upcase)
    end

    guess
  end

  def get_code()
    code = []
    for i in 1..4
      puts "Enter letter #{i} for your code."
      input = gets.chomp

      while (input.downcase != 'r' and input.downcase != 'b' and input.downcase != 'g' and input.downcase != 'y' and             input.downcase != 'w' and input.downcase != 'p')

        puts "Invalid entry. Please enter letter #{i} for your code."
        input = gets.chomp
      end

      code.push(input.upcase)
    end

    @code = code
  end

end

test = Match.new()
test.play


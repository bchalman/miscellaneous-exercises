class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def enter_code(game = nil)
    code = gets.chomp
    code = code.downcase.split.each{ |color| color.strip}
    game.make_code(code) unless game.nil?
    code
  end

  def make_code(game = nil)
    print "Please Enter a Secret Code:"
    enter_code(game)
  end

  def guess_code
    print "What is your guess?"
    enter_code
  end

end

class Computer < Player
  attr_reader :name
  def initialize(game)
    @name = ["Bot Bob","Mr.C0mputer","Miss.Mastermind","Not_A_ROBOT"].sample
    @game = game
    @rand = (0...Mastermind.colors.length).to_a.shuffle
    # puts @rand
  end

  def enter_code(game = nil)
    code = []
    4.times { code.push(Mastermind.colors.sample) }
    # game.make_code(code) unless game.nil?
    code
  end

  def make_code(game = nil)
    puts "You will never guess my Secret Code"
    enter_code(game)
  end

  def guess_code
    @AI_iterator||=0
    code = []
    # if @game.feedback_array[-1].nil? || @game.feedback_array[-1].length == 0
    #   code.push(Mastermind.colors[@rand[@game.feedback_array.length % @rand.length]]) while code.length < 4
    #   # puts ":: #{ @game.feedback_array.length % @rand.length}"
    # elsif !@game.feedback_array[-1].include?("white")
    # end
    if @game.feedback_array[-1].nil?
      code.push(Mastermind.colors.sample) while code.length < 4
    elsif @game.feedback_array[-1].length == 4
      code = @game.guess_array[-1].dup
      code.shuffle! while @game.guess_array.include?(code)
    else
      index = @game.feedback_array.index(@game.feedback_array.max_by{ |e| e.count("black")*1.1+e.count("white") })
      @AI_iterator += 1 unless @game.feedback_array[-1].length == @game.feedback_array[index].length
      code = @game.guess_array[index].dup#.shuffle
      code[@AI_iterator%4] = Mastermind.colors[@game.feedback_array.length%Mastermind.colors.length]
      # code.shuffle! if @game.feedback_array[index].any? { |e| e=="white"  }
      # @game.feedback_array[index].each_index{ |i| code.push(@game.guess_array[index][i]) }
      # code.push(Mastermind.colors.sample) while code.length < 4
      # code.shuffle!
    end

    code.push(Mastermind.colors.sample) while code.length < 4
    code
  end

end

class Mastermind
  attr_reader :codemaker
  attr_reader :codebreaker
  # attr_reader :code # get rid of this when done coding
  attr_reader :difficulty
  attr_reader :guess_array
  attr_reader :feedback_array
  @@colors = ["red" , "purple", "blue", "green", "orange", "yellow"]


  def initialize(codemaker,codebreaker)
    @codemaker = codemaker == "computer" ? Computer.new(self) : Player.new(codemaker)
    @codebreaker = codebreaker == "computer" ? Computer.new(self) : Player.new(codebreaker)
    @code = Array.new(4)
    @difficulty = 8
    @guess_array = Array.new(0)
    @feedback_array = Array.new(0)
  end

  def Mastermind.colors
    @@colors
  end

  def valid_code? (code = @code)
    valid = true
    valid = false unless code.is_a?(Array) && code.length == 4 && code.all? { |color|  @@colors.include?(color)}
    puts "invalid code" unless valid
    return valid

  end

  def make_code( code )
    @code = code
  end

  def new_guess(guess)
    return unless valid_code?(guess)
    @guess_array << guess
    feedback(guess)
    guess

  end

  def feedback( guess )
    return unless valid_code?(guess)
    temp_code = @code.dup
    feedback = Array.new
    guess = guess.dup
    guess.each_index do |i|
      if guess[i] == @code[i]
        feedback << "black"
        guess[i]="black"
        temp_code[i]=nil
      end
    end
    guess.each_index do |i|
      if  temp_code.include?(guess[i])
        feedback << "white"
        temp_code[temp_code.index(guess[i])]=nil
        guess[i]="white"
      end
    end
    @feedback_array << feedback
    feedback
  end

  def show_board(show_code = false)
    puts ""
    puts ""
    puts "Colors: #{@@colors.join("  ")}".center(60)
    puts "".center(60,"*")
    @feedback_array.each_index do |i|
      puts "Guess #{i}: #{@guess_array[i].join(" ")}".ljust(40) + " :  #{@feedback_array[i].join(" ")}"
    end
    if show_code
      puts "".center(38,"-").center(50)
      puts "| Secret Code: #{@code.join(" ")} |".center(50)
      puts "".center(38,"-").center(50)
    end
    puts "".center(60,"*")
    puts ""
    puts ""
  end

  def game_over?
    if @guess_array.include?(@code)
      show_board(true)
      puts "Contrats!"
      puts "Codebreaker #{@codebreaker.name} broke the Secret Code"
      return @codebreaker
    end

  if @guess_array.length > @difficulty
    show_board(true)
    puts "Codemaker's #{@codemaker.name} Secret Code could not be craked"
    return @codemaker
  end
    false
  end


end

puts "Lets play Mastermind"
print "Who are you? enter name: "
name = gets.chomp
role = ""
loop do
  print "Are you are Codemaker or Codebreaker? "
  role = gets.chomp.strip.downcase
  break if role == "codebreaker" || role == "codemaker"
end

game = role == "codebreaker" ? Mastermind.new("computer",name) : Mastermind.new(name, "computer")

loop {game.make_code(game.codemaker.make_code) ; break if game.valid_code?}

puts "#{game.codebreaker.name} can you guess the secret code"
puts "Colors: #{Mastermind.colors.join("  ")}".center(60)
loop do
  code_guess =""
  loop { code_guess = game.codebreaker.guess_code ; break if game.valid_code?(code_guess)}
  game.new_guess(code_guess)
  break if game.game_over?#feedback.length == 4 && feedback.all? { |e| e == "black" }
  game.show_board unless game.codebreaker.instance_of? Computer
  # puts "feedback #{feedback.inspect}"
end
puts "GAME OVER"

dictionary = File.read("5desk wordlist.txt")
dictionary = dictionary.split
# puts dictionary.inspect
# puts word = dictionary.select{|word| word.length >= 5 && word.length <= 12 }.sample

class Hangman
  attr_reader :misses
  attr_reader :word
  def initialize(player, dictionary)
    @player = player
    @word = dictionary.select{|word| word.length >= 5 && word.length <= 12 }.sample
    @misses = []
    @correct_letters = []
  end

  def guess(letter)
    letter = letter.downcase
    if letter.length == 1  && ((@misses+@correct_letters).nil? || !(@misses+@correct_letters).include?(letter))
        @word.chars.include?(letter) ? @correct_letters << letter : @misses << letter
        return true
    end
    false
  end

  def show_correct
    puts known = @word.chars.map { |letter| @correct_letters.include?(letter) ? letter : "_"   }.join
    if known == @word
      return true
    end
    false
  end

  def game_state?
    if show_correct
      puts "You figgured out the word"
      return 1
    end
    unless show_hangman
      puts "Too many incorrect guess"
      puts "The word was: " + game.word
      return -1
    end
    0
  end

  def show_hangman
    @misses.each { |miss| print "\e[9m#{miss}\e[0m " }
    puts ""
    puts "#{@misses.length} of 8 misses"
    @misses.length < 8 ? true :false
  end

  def save
    print "enter file name:"
    file_name = gets.chomp
    File.open(file_name,'w') do |file|
      file.puts Marshal::dump(self)
    end
    end

end

puts "lets play Hangman."
puts "8 incorrect guesses and you lose"
puts "type exit at anytime to save and exit"
print "press enter to start a new game or if you want to load a game enter the name of the savefile: "
loadfile = gets.chomp
if File.file?(loadfile)
  loadfile = File.read(loadfile)
  game = Marshal::load(loadfile)
else
  puts "File not found Starting new game" unless loadfile.length == 0
  game = Hangman.new("max" , dictionary)
end
game.show_correct
loop do
  puts ""
  print "guess a letter: "
  while !game.guess(input = gets.chomp) do
    if input == "exit"
      game.save
      break
    end
    puts "repeated letter or invalid input"
    print "guess a letter: "
  end

  break if game.game_state? != 0 || input == "exit"
end

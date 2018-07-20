class Player
  attr_reader :name
  attr_reader :token
  attr_accessor :avaible_tokens
  @@avaible_tokens = []
  def initialize(name)
    @name = name
    @token = @@avaible_tokens.delete(@@avaible_tokens.sample)
  end

  def self.avaible_tokens=(array)
    @@avaible_tokens = array
  end
end

class TicTacToe
  attr_reader :whos_turn
  # @game_state=[]

  def initialize(player_1,player_2)
    # add: let take Player or a string
    Player.avaible_tokens = ["X","O"]
    @players = [Player.new(player_1),Player.new(player_2)]
    @whos_turn = @players[0].token == "X" ? @players[0] : @players[1]
    @game_state = Array.new(3){Array.new(3)} #should I make this a hash?
  end

  def next_turn
    @whos_turn = @players[(@players.index(@whos_turn)+1)%2]
    return @whos_turn
  end

  def show_board
     @game_state.each_index do |row|
       3.times do |i|
         @game_state[row].each_index do |collumn|
           print (i==1 ? @game_state[row][collumn].to_s : "").center(10)
           print (collumn < @game_state[row].length - 1) ? "|" : "\n"
         end
       end
       puts (row < @game_state.length - 1) ? "".center(11*@game_state[row].length - 1,"—") : ""
     end
    puts ""
  end

  def play(position, player = @whos_turn)
    position = position.downcase.split
    return "Can not read position" unless position.length == 2
    case position[0].strip[0]
      when "t"
        position[0]=0
      when "m"
        position[0]=1
      when "b"
        position[0]=2
    end
    case position[1].strip[0]
      when "r"
        position[1]=2
      when "m"
        position[1]=1
      when "l"
        position[1]=0
    end

    return "Can not read position" unless position[0].is_a?(Integer) && position[1].is_a?(Integer)
    return "That spot is allready taken" unless @game_state[position[0]][position[1]] == nil
    @game_state[position[0]][position[1]] = player.token
    true

  end

  def draw?
    # returns true even if game as been won, check game_over? 1st
    return true unless @game_state.flatten.any? { |e|  e.nil?}
    false
  end

  def game_over?
    game_over = false
    @game_state.each do |collumn|
      game_over = true if collumn.uniq != [nil] && collumn.uniq.length == 1
    end
    @game_state.transpose.each do |collumn|
      game_over = true if collumn.uniq != [nil] && collumn.uniq.length == 1
    end
    cross_array = [@game_state[0][0],@game_state[1][1],@game_state[2][2]]
    game_over = true if cross_array.uniq != [nil] && cross_array.uniq.length == 1
    cross_array = [@game_state[2][0],@game_state[1][1],@game_state[0][2]]
    game_over = true if cross_array.uniq != [nil] && cross_array.uniq.length == 1
    game_over

  end

  def self.start_game
    puts "Lets play Tic Tac Toe"
    print "Player 1 enter name: "
    player_1_name = gets.chomp
    print "Player 2 enter name: "
    player_2_name = gets.chomp
    game = TicTacToe.new(player_1_name,player_2_name)

    puts "Enter your choice using the format:"
    puts "row(top, middle bottom) collumn(right, middle, left)"
    puts "example: top left"
    puts "#{game.whos_turn.name} is X and goes 1st"
    game.play_game
  end

  def play_game
    loop {
      show_board
      print "Your turn #{whos_turn.name} where do you want to play? "
      move = gets.chomp
      break if move.downcase == "exit"
      current_play = play(move)
      puts current_play unless current_play==true
      if game_over?
        show_board
        puts "GAME OVER! #{whos_turn.name} Wins"
        break
      end
      if draw?
        show_board
        puts "Game is a Draw"
        break
      end
      next_turn if current_play==true
   }
 end

end


# puts "Lets play Tic Tac Toe"
# print "Player 1 enter name: "
# player_1_name = gets.chomp
# print "Player 2 enter name: "
# player_2_name = gets.chomp
# game = TicTacToe.new(player_1_name,player_2_name)
#
# puts "Enter your choice using the format:"
# puts "row(top, middle bottom) collumn(right, middle, left)"
# puts "example: top left"
# puts "#{game.whos_turn.name} is X and goes 1st"
# loop {
#   game.show_board
#   print "Your turn #{game.whos_turn.name} where do you want to play? "
#   move = gets.chomp
#   break if move.downcase == "exit"
#   play = game.play(move,game.whos_turn)
#   puts play unless play==true
#   if game.game_over?
#     game.show_board
#     puts "GAME OVER! #{game.whos_turn.name} Wins"
#     break
#   end
#   if game.draw?
#     game.show_board
#     puts "Game is a Draw"
#     break
#   end
#   game.next_turn if play==true
#  }


# puts game.play("bottom l",game.whos_turn)
# game.next_turn
# game.play("top left",game.whos_turn)
# game.show_board

require_relative "Connect_Four"

puts "Lets play Connect Four"
Player.avaible_tokens = ["\e[31m@\e[0m" , "\e[33m@\e[0m"]
print "Player 1 enter Name:"
player_1 = Player.new(gets.chomp)
print "Player 2 enter Name:"
player_2 = Player.new(gets.chomp)
puts "#{player_1.name} is #{player_1.token}"
puts "#{player_2.name} is #{player_2.token}"

game = ConnectFour.new(player_1,player_2)
game_over = ""
loop do
  puts ""
  game.show_board
  puts ""
  puts "#{game.whos_turn.token}:#{game.whos_turn.name} it is your turn"
  print "#{game.whos_turn.token}:what column do you want to play in? "
  play = game.place_disk(gets.chomp)
  puts play unless play == "success"
  if play == "success"
    break if game_over = game.game_over?
    game.next_turn
  end
end
puts ""
puts "".center(50,"*")
puts "".center(50,"*")
game.show_board
puts ""
puts game_over == "draw" ?  "Tie Game" : "CONTRATS!!! #{game.whos_turn.name} won the game"
puts ""
puts "".center(50,"*")
puts "".center(50,"*")
puts ""

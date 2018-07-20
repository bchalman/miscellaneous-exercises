require_relative "Tic Tac Toe"

TicTacToe.start_game
#
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

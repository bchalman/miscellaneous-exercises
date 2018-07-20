class Chessboard
  attr_reader :board
  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def valid_position? ( position )
    position.each{ |i| return false unless i>=0 && i<8}
    # return false unless @board[position[0]][position[1]].nil?
    # puts position.inspect
    true
  end

  def print_board
    @board.each_with_index do |row, i|
      print "#{i}: "
      row.each do |space|
        print "[#{(space.nil? ? "" : space.position.inspect ).center(10)}]" #space.class.name
      end
      puts ""
    end
    print "   "
    8.times { |j| print j.to_s.center(12) }
    puts ""
  end


end

class Knight
  attr_reader :position
  attr_reader :avaible_moves
  attr_reader :board
  attr_reader :parent
  def initialize(position , board = Chessboard.new, parent = nil)
    @position = position
    @avaible_moves = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
    @parent = parent
    @board = board
    board.board[position[0]][position[1]] = self
    @avaible_moves = @avaible_moves.select do |move|
      move[0] += position[0]
      move[1] += position[1]
      board.valid_position?(move)
    end
  end

  def path
    path_array = [self]
    while !path_array[0].parent.nil?
      path_array.unshift(path_array[0].parent)
    end
    path_array.map!{|knight| knight.position}
  end
end

def knight_moves(start_position, end_position, board = Chessboard.new)
  starting_knight = Knight.new(start_position , board)
  queue = [starting_knight]
  knight = starting_knight
  time_out = 0
  loop do
    time_out +=1
    knight = queue.shift
    break if knight.position == end_position
    knight.avaible_moves.each do |child_knight|
      queue << Knight.new(child_knight , board, knight)
    end
    # break if time_out > 20
  end
  path = knight.path
  puts "You made it in #{path.length} moves!  Heres your path:"
  path.each_with_index{|position, i| print "#{i!=0 ? "-> " : ""}(#{position[0]}, #{position[1]}) "}
  puts ""
  return knight

end


board = Chessboard.new
knight = knight_moves([1,3],[6,5])
# knight.board.print_board
# puts ""
# puts knight.path.inspect

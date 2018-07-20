class Player
  attr_reader :name
  attr_reader :token
  attr_accessor :avaible_tokens
  @@avaible_tokens = []
  def initialize(name, token = nil)
    @name = name
    if token.nil?
      @token = @@avaible_tokens.delete(@@avaible_tokens.sample)
    else
      @token = token
    end
  end

  def self.avaible_tokens=(array)
    @@avaible_tokens = array
  end
end

class ConnectFour
  attr_reader :players
  attr_reader :whos_turn
  attr_reader :board
  def initialize(player_1,player_2)
    @players = [player_1,player_2]
    @whos_turn = player_1
    @board = Array.new(6){Array.new(7)}
    next_turn if [true,false].sample
  end

  def next_turn
    @whos_turn = @players[(@players.index(@whos_turn)+1)%2]
    return @whos_turn
  end

  def show_board
    puts ""
    @board.each do |row|
      print "|"
     row.each_with_index do |position, i|

      if position.nil?
         print " O "
       else
         print " #{position} "
       end
     end
     puts "|"
    end
    puts "".center(23,"~")
    print " "
    @board[1].each_index{|i| print "[#{i}]".center(3)}
    puts ""
    return @board
  end

  def place_disk(column)
    column = column.to_i
    return "invalid column" unless column.is_a?(Integer) && column >= 0 && column < 7
    return "column full" unless @board[0][column].nil?
    @board[0][column] = @whos_turn.token
    # show_board
    fall
    return "success"
  end

  def fall
    @board.each_with_index do |row, i|
     row.each_with_index do |position, j|
      unless position.nil?
        # @board[i][j] = i unless i>6
        @board[i][j] ,  @board[i+1][j] = nil , position if i<5 && @board[i+1][j].nil?
      end
     end
    end
    return @board
  end

  def game_over?


    @board.each do |row|
      return true if in_a_row(row,4)  # change return to be winner?
    end
    @board.transpose.each do |row|
      return true if in_a_row(row,4)  # change return to be winner?
    end
    diagonals.each do |diagonal|
      return true if in_a_row(diagonal,4)
    end
    return "draw" if @board.all?{ |row| row.none?{ |position| position.nil?} }
    false
  end

  def diagonals
    diagonals = []
    diagonal = []
    @board.each_with_index do |row,i|
      diagonal = []
      row.each_index do |j|
        diagonal << @board[i-j][j] unless i-j < 0
      end
      diagonals << diagonal
      diagonal = []
      row.each_index do |j|
        diagonal << @board[i-j][-(1+j)] unless i-j < 0
      end
      diagonals << diagonal
    end
    @board[0][1..-1].each_index do |i|
      diagonal = []
      @board[0][i..-1].each_index do |j|
        diagonal <<  @board[@board.length-j][j+i] unless @board[@board.length-j].nil?
      end
      diagonals << diagonal
      diagonal = []
      @board[0][i..-1].each_index do |j|
        diagonal <<  @board[@board.length-j][-(1+j+i)] unless @board[@board.length-j].nil?
      end
      diagonals << diagonal
    end
  diagonals
  end


end

def in_a_row(array, number)
  token = nil
  connected = 1
  array.each do |e|
    if e.nil? || token != e
      token = e
      connected = 1
      next
    end
    token = e
    connected += 1
    return true unless connected < number # change return to be winner?
  end
  return false
end

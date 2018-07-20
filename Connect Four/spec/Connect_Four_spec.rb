require "Connect_Four"

describe Player do
  describe "#new" do
    it "initializes a new player with namen" do
      expect(Player.new("Max").name).to  eql("Max")
    end
    it "and optional token" do
      expect(Player.new("Max","@").token).to  eql("@")
    end

  end
end

describe ConnectFour do
  let(:player_1){Player.new("Max","\e[31m@\e[0m")}
  let(:player_2){Player.new("Dog","\e[33m@\e[0m")}
  subject(:game) do
    ConnectFour.new(player_1,player_2)
  end

  describe "#new" do
    it "initializes a new game with 2 Players" do
      expect(ConnectFour.new(player_1,player_2).players.length).to  eql(2)
      # puts ConnectFour.new(player_1,player_2).players[1].token
    end
    it "whos_turn should be player_1" do
      game.instance_variable_set("@whos_turn" , game.players[0])
      expect(ConnectFour.new(player_1,player_2).whos_turn).to  eql(player_1)
      # puts ConnectFour.new(player_1,player_2).players[1].token
    end
  end

  describe "#next_turn" do
      it "switches current player" do
        game.instance_variable_set("@whos_turn" , game.players[0])
        game.next_turn
        expect(game.whos_turn).to eql(player_2)
      end
      it "and returns the new current_player" do
        game.instance_variable_set("@whos_turn" , game.players[0])
        expect{game.next_turn}.to change(game, :whos_turn).from(player_1).to(player_2)
      end
  end

  describe "#show_board" do
    it "shows the board" do
      puts ""
      # game.show_board
      expect(game.show_board).to eql(game.board)
    end
  end

  describe "#place_disk" do
    it "returns 'success' if vaild column and column not full" do
      expect(game.place_disk(3)).to eql("success")
    end

    it "returns 'column full' if their is a token in the top row of the column" do
      game.board[0][4] = "X"
      expect(game.place_disk(4)).to eql("column full")
    end

    it "returns 'invalid column' if column is not int from 0 to 6 " do
      expect(game.place_disk(8)).to eql("invalid column")
    end
    it "returns 'invalid column' if column is not int from 0 to 6 " do
      expect(game.place_disk("cat")).to eql("invalid column")
    end
  end

  describe "#fall" do
    it "return and update the game board such that no token have empty spaces under them" do
      game.board[0][4] = "X"
      top_row = game.board[0].inspect

      expect(game.fall[5].inspect).to eql(top_row)

    end
  end

  describe "#game_over?" do
    it "empty board" do
      expect(game.game_over?).to be false
    end
    it "partially filled board" do
      game.board[2] = [nil,"X","X","O","X",nil,"V"]
      game.board[3] = ["n","X","C","X","X",nil,nil]
      game.board[4] = [nil,"X","D","O","G",nil,"M"]
      expect(game.game_over?).to be false
    end
    it "full board no 4 connected" do
      game.instance_variable_set("@board" , Array.new(6){|i| Array.new(7){|j| i+10*j}} )
      expect(game.game_over?).to eql("draw")
    end
    it "4 connected in a row" do
      game.board[2] = [nil,"X","X","X","X",nil,nil]
      expect(game.game_over?).to be true
    end
    it "4 connected in a column" do
      4.times{ |i| game.board[2+i][3] = "X"}
      expect(game.game_over?).to be true
    end
    it "4 connected in down diagonal" do
      4.times{ |i| game.board[2+i][3+i] = "X"}
      expect(game.game_over?).to be true
    end
    it "4 connected in up diagonal" do
      4.times{ |i| game.board[2+i][6-i] = "X"}
      expect(game.game_over?).to be true
    end
    it "full board with 4 connected" do
      game.instance_variable_set("@board" , Array.new(6){|i| Array.new(7){|j| i+10*j}} )
      4.times{ |i| game.board[2+i][3] = "X"}
      expect(game.game_over?).to be true
    end
  end


end

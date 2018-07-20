require "Tic Tac Toe"



describe TicTacToe do
  subject(:game){TicTacToe.new("Max","Cat")}
  before do
    @current_player = game.whos_turn
  end

  describe "#next_turn" do
      it "switches current player" do
        game.next_turn
        expect(game.whos_turn).not_to eql(@current_player)
      end
      it "and returns the new current_player" do
        expect(game.next_turn).not_to eql(@current_player)
      end
  end

  describe "#show_board" do
    it "shows the board" do
      puts ""
      game.show_board
    end
  end

  describe "#play" do
   context "given a position" do
     it "given 'top left' returns true" do
       expect(game.play("top left")).to eql(true)
     end

     it "given abbreviation 't l' returns true" do
       expect(game.play("t l")).to eql(true)
     end

     it "given incomplete move 'top' returns 'Can not read position'" do
       expect(game.play("top")).to eql("Can not read position")
     end

     it "given nonsense move 'cat dog' returns 'Can not read position'" do
       expect(game.play("cat dog")).to eql("Can not read position")
     end

     it "given an occupied space 'top left' returns 'That spot is allready taken'" do
       game.play("top left")
       expect(game.play("top left")).to eql("That spot is allready taken")
     end

   end
  end

  describe "draw?" do
    it "given a new game" do
      expect(game.draw?).to eql(false)
    end
    it "check mid game" do
      game.instance_variable_set("@game_state", [[nil, "X", nil], [nil, "O", nil], ["X", nil, nil]])
      expect(game.draw?).to eql(false)
    end
    it "check game with full board" do
      game.instance_variable_set("@game_state", [["O", "X", "O"], ["O", "O", "X"], ["X", "O", "X"]])
      expect(game.draw?).to eql(true)
    end
  end

  describe "game_over?" do
    it "given a new game" do
      expect(game.game_over?).to eql(false)
    end
    it "check mid game" do
      game.instance_variable_set("@game_state", [[nil, "X", nil], [nil, "O", nil], ["X", nil, nil]])
      expect(game.game_over?).to eql(false)
    end

    it "check x accross" do
      game.instance_variable_set("@game_state", [["X", "X", "X"], [nil, "O", nil], ["X", nil, nil]])
      expect(game.game_over?).to eql(true)
    end

    it "check o accross" do
      game.instance_variable_set("@game_state", [[nil, "X", nil], ["O", "O", "O"], ["X", "X", nil]])
      expect(game.game_over?).to eql(true)
    end

    it "check x down" do
      game.instance_variable_set("@game_state", [[nil, "X", nil], [nil, "X", nil], ["O", "X", nil]])
      expect(game.game_over?).to eql(true)
    end

    it "check x diagonal" do
      game.instance_variable_set("@game_state", [["X", "X", nil], [nil, "X", nil], ["O", nil, "X"]])
      expect(game.game_over?).to eql(true)
    end

  end

end

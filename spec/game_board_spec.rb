require './game_board.rb'

describe GameBoard do
  let!(:game_board) do
    @game_board = GameBoard.new
  end

  describe "#initialize" do
    it "has a length of 7" do
      expect(game_board.board.length).to eql(7)
    end

    it "has a height of 6" do
      expect(game_board.board[0].length).to eql(6)
    end
  end

  describe "#make_move" do
    it "enters a player move" do
      expect(game_board.make_move(1, 'x')).to eql('x')
    end

    it "returns false on a full row" do
      @game_board.board[0] = ['x','x','x','x','x','x']
      expect(game_board.make_move(1, 'x')).to eql(false)
    end 
  end


end


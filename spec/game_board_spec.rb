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
    it "enters a x player move" do
      expect(game_board.make_move(1, 'x')).to eql('x')
    end

    it "enters a o player move" do
      expect(game_board.make_move(7, 'o')).to eql('o')
    end

    it "returns false if column is outside of board limits" do
      expect(game_board.make_move(8, 'x')).to eql(false)
    end

    it "returns false on a full row" do
      @game_board.board[0] = ['x','x','x','x','x','x']
      expect(game_board.make_move(1, 'x')).to eql(false)
    end 

    it "only enters 1 move per call" do
      game_board.make_move(1, 'x')
      expect(game_board.board[1][0]).to eql(nil)
    end
  end

  describe "#check_winner" do
    it "returns true if vertical winner is found" do
      game_board.board[5] = [nil,'x','x','x','x','o']
      expect(game_board.check_winner('x')).to eql(true)
    end

    it "returns true of horizontal winner with a gap after first instance" do
      game_board.make_move(1, 'x')
      game_board.make_move(2, 'o')
      game_board.make_move(3, 'x')
      game_board.make_move(4, 'x')
      game_board.make_move(5, 'x')
      game_board.make_move(6, 'x')
      expect(game_board.check_winner('x')).to eql(true)
    end

    it "returns true if a horizontal winner is bottom row" do
      for i in 1..4
        game_board.make_move(i, 'x')
      end
      expect(game_board.check_winner('x')).to eql(true)
    end

    it "returns true if a horizontal winner is found in middle of board" do
      for i in 3..6
        @game_board.board[i] = ['o','o','x', nil, nil, nil]
      end
      expect(game_board.check_winner('x')).to eql(true)
    end
  
    it "returns false if no horizontal winner is found" do
      for i in 1..4
        if i%2 == 0
          @game_board.make_move(i, 'x')
        else
          @game_board.make_move(i, 'o')
        end
      end
      expect(game_board.check_winner('x')).to eql(false)
    end
  
    it "returns true if a diagonal winner is found" do
      for i in 0..3
        for j in 0..5
          if j < i
            @game_board.board[i][j] = 'o'
          elsif j == i
            @game_board.board[i][j] = 'x'
          else
            @game_board.board[i][j] = nil
          end
        end
      end
      expect(game_board.check_winner('x')).to eql(true)
    end

    it "returns true if a diagonal winner going down to the right is found" do
      game_board.board[0] = ['o','o','o','o','o','x']
      game_board.board[1] = ['o','o','o','o','x',nil]
      game_board.board[2] = ['o','o','o','x',nil,nil]
      game_board.board[3] = ['o','o','x',nil,nil,nil]
      expect(game_board.check_winner('x')).to eql(true)
    end

    it "returns false if a diagonal has 4 in it but not in a row" do
      game_board.board[0] = ['x',nil,nil,nil,nil,nil]
      game_board.board[1] = ['o','x',nil,nil,nil,nil]
      game_board.board[2] = ['o','o','o',nil,nil,nil]
      game_board.board[3] = ['x','x','o','x',nil,nil]
      game_board.board[4] = ['x','x','o','x','x',nil]
      expect(game_board.check_winner('x')).to eql(false)
    end
    
      it "returns true if a diagonal winner has been found with a gap from the first instance" do
        game_board.board[0] = ['x',nil,nil,nil,nil,nil]
        game_board.board[1] = ['o','o',nil,nil,nil,nil]
        game_board.board[2] = ['o','o','x',nil,nil,nil]
        game_board.board[3] = ['x','x','o','x',nil,nil]
        game_board.board[4] = ['x','x','o','x','x',nil]
        game_board.board[5] = ['x','x','o','o','o','x']
        expect(game_board.check_winner('x')).to eql(true)
      end
  end

  describe "#display_board" do
    it "displays an empty board" do
      expect{game_board.display_board}.to output("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n").to_stdout
    end

    it "displays an updated board after 1 move" do
      game_board.make_move(1,'x')
      expect{game_board.display_board}.to output("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| x | * | * | * | * | * | * |\n").to_stdout
    end

    it "displays an updated board  after multiple moves" do
      game_board.make_move(1,'x')
      game_board.make_move(1,'o')
      game_board.make_move(5,'o')
      game_board.make_move(4,'x')
      game_board.make_move(4,'x')
      expect{game_board.display_board}.to output("| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| * | * | * | * | * | * | * |\n| o | * | * | x | * | * | * |\n| x | * | * | x | o | * | * |\n").to_stdout
    end
  end

  describe "#is_tie?" do
    it "returns true if board is full" do
      game_board.board[0] = ['x','x','o','x','x','o']
      game_board.board[1] = ['o','x','x','o','x','o']
      game_board.board[2] = ['x','o','o','x','o','o']
      game_board.board[3] = ['o','o','o','x','o','x']
      game_board.board[4] = ['x','o','x','x','o','o']
      game_board.board[5] = ['o','x','o','o','x','o']
      game_board.board[6] = ['o','x','o','x','o','o']
      expect(game_board.is_tie?).to eql(true)
    end

    it "returns false if there are empty spaces" do
      for i in 0..10
        if i%2 == 0
          game_board.make_move(rand(7)+1,'o')
        else
          game_board.make_move(rand(7)+1,'x')
        end
      end
      expect(game_board.is_tie?).to eql(false)
    end
  end
end




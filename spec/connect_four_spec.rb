require './connect_four.rb'
require './game_board.rb'

describe ConnectFour do
  
  let!(:game) do
    @game = ConnectFour.new
  end

  it "creates board when initialized" do 
    expect(game.game_board).to be_instance_of(GameBoard)
  end

  describe "#start_game" do
    it "plays the game until player x wins" do
      allow(game).to receive(:gets).and_return('1','2','1','2','1','2','1')
      expect{ game.start_game }.to output(/Player x got 4 in a row!\n/).to_stdout
    end 

    it "switches players after each turn" do
      allow(game).to receive(:gets).and_return('1','4','1','2','1','6','1','2')
      expect{game.start_game}.to change { game.player_turn }.from('o').to('x')
    end

    it "plays to a tie" do
      allow(game).to receive(:gets).and_return('1','2','3','4','5','6','1','7','2','3','2','4','6','5','7','1','5','3','1','4','3','6','4','7','5','2','7','6','2','3','1','4','6','5','4','7','5','1','2','3','7','6')
      expect{game.start_game}.to output(/It's a tie! The board is full./).to_stdout
    end
  end

  describe "#get_move" do
    it "prompts player 'x' to enter their guess" do
      allow(game).to receive(:gets).and_return('1')
      expect{ game.get_move('x') }.to output(/Player x please enter the column you want to place your piece:\n/).to_stdout
    end

    it "prompts player 'o' to enter their guess" do
      allow(game).to receive(:gets).and_return('1')
      expect{ game.get_move('o') }.to output(/Player o please enter the column you want to place your piece:\n/).to_stdout
    end

    it "accepts a number in range of 1-7" do
      allow(game).to receive(:gets).and_return('5')
      expect(game.get_move('x')).to eql(5)
    end

    it "prompts again if non-integer is entered" do
      allow(game).to receive(:gets).and_return('a', '1')
      expect{ game.get_move('x') }.to output(/Invalid move, try again/).to_stdout
    end

    it "prompts again if integer enetered is outside of board range" do
      allow(game).to receive(:gets).and_return('8', '1')
      expect{ game.get_move('x') }.to output(/Invalid move, try again/).to_stdout
    end
  end
end
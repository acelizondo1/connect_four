require './connect_four.rb'
require './game_board.rb'

describe ConnectFour do
  let!(:game) do
    @game = ConnectFour.new
  end

  it "creates board when initialized" do 
    expect(game.game_board).to be_instance_of(GameBoard)
  end
end
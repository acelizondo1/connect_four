require 'game_board.rb'

class ConnectFour 
  attr_reader :game_board

  def initialize
    @game_board = GameBoard.new
  end

end
class GameBoard
attr_reader :board

  def initialize
    @board = Array.new(7, Array.new(6))
  end

  def make_move(column, player)
    unless column >= @board.length || column < 0
      for row in 0..5
        if @board[column-1][row] == nil
          @board[column-1][row] = player 
          return @board[column-1][row]
        end
      end
    end
    false
  end
end
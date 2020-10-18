class GameBoard
attr_reader :board

  def initialize
    @board = Array.new(7){ Array.new(6) }
  end

  def make_move(column, player)
    unless column > @board.length || column < 0
      for row in 0..5
        if @board[column-1][row] == nil
          @board[column-1][row] = player
          return @board[column-1][row]
        end
      end
    end
    false
  end

  def check_winner(player)
    if vertical_winner?(player) || horizontal_winner?(player) || diagonal_winner?(player)
      true
    else
      false
    end
  end

  def display_board
    puts "| 1 | 2 | 3 | 4 | 5 | 6 | 7 |"
    for row in 5.downto(0)
      row_string = "|"
      for column in 0..@board.length-1
        if @board[column][row] == nil 
          cell = "*" 
        else 
          cell = @board[column][row]
        end
        row_string += " #{cell} |"
      end
      puts row_string
    end
  end

  def is_tie?
    for column in 0..6
      for row in 0..5
        return false if @board[column][row] == nil
      end
    end
    true
  end

  private
  def vertical_winner?(player)
    for column in 0..6
      count = 0
      for row in 0..5
        @board[column][row] == player ? count += 1 : count = 0
        return true if count >= 4
      end
    end
    false
  end

  def horizontal_winner?(player)
    for col in 0..3
      for cell in 0..5
        if @board[col][cell] == player
          count = 1
          for i in 1..3
            @board[col+i][cell] == player ? count += 1 : break
          end
          return true if count >= 4
        end
      end
    end
    false
  end

  def diagonal_winner?(player)
    for col in 0..3
      for cell in 0..5
        if @board[col][cell] == player 
          count = 1
          if @board[col+1][cell+1] == player
            for i in 1..3
              @board[col+i][cell+i] ==player ? count += 1 : break
            end 
          elsif cell > 0 && @board[col+1][cell-1] == player
            for i in 1..3
              @board[col+i][cell-i] ==player ? count += 1 : break
            end 
          end
          return true if count >= 4
        end
      end
    end
    false
  end
end

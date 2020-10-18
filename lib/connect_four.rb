require_relative 'game_board.rb'

class ConnectFour 
  attr_reader :game_board, :player_turn

  def initialize
    @game_board = GameBoard.new
    @player_turn = "o"
  end

  def start_game
    until @game_board.check_winner(@player_turn) || @game_board.is_tie?
      @player_turn == 'o' ? @player_turn = 'x' : @player_turn = 'o'
      @game_board.display_board
      move = get_move(@player_turn)
      until @game_board.make_move(move, @player_turn)
        move = get_move(@player_turn)
      end
    end
    @game_board.display_board
    if @game_board.is_tie?
      puts "It's a tie! The board is full."
    else
      puts "Player #{@player_turn} got 4 in a row!"
    end
  end

  def get_move(player)
    puts "Player #{player} please enter the column you want to place your piece:"
    begin
      move = gets.chomp
      return move.to_i if move.to_i < 8 && move.to_i > 0 
      raise(ArgumentError, "Invalid Input")
    rescue ArgumentError
      puts "Invalid move, try again"
      retry
    end
  end
end 

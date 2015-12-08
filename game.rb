require_relative 'board'
require_relative 'display'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @current_player = :blue
  end


  def run
    until @board.checkmate?(@current_player)
      piece_pos = select_piece
      move_piece(piece_pos)
      next_player!
    end
    puts "Checkmate! #{@current_player.capitalize} loses."
  end

  def select_piece
    piece_pos = nil
    until piece_pos && @board.valid_piece?(piece_pos, @current_player)
      @display.render
      puts "Check!" if @board.in_check?(@current_player)
      puts "#{@current_player.capitalize}, select a piece."
      piece_pos = @display.get_input
    end
    if @board[piece_pos].valid_moves.empty?
      puts "No moves for this piece."
      sleep(1)
      piece_pos = select_piece
    end
    @display.select_piece(piece_pos)
    return piece_pos
  end

  def move_piece(piece_pos)
    end_pos = nil
    until end_pos && @board.valid_move?(piece_pos, end_pos)
      @display.render
      puts "Select a move."
      end_pos = @display.get_input
    end

    @display.select_piece(nil)
    @board.move(piece_pos, end_pos)

  end



  def next_player!
    # players.reverse!
    if @current_player == :blue
      @current_player = :black
    else
      @current_player = :blue
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  # puts "Player 1 name?"
  # name1 = gets.chomp
  # puts "Player 2 name?"
  # name2 = gets.chomp
  # player1 = Player.new(name1)
  # player2 = Player.new(name2)
  #
  # Game.new([player1, player2]).run

  Game.new.run
end

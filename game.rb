require_relative 'board'
require_relative 'display'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def run

    piece_pos = nil
    until piece_pos
      @display.render
      puts "Select a piece."
      piece_pos = @display.get_input
    end

    end_pos = nil
    until end_pos
      @display.render
      puts "Select a move."
      end_pos = @display.get_input
    end

    p piece_pos
    p end_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end

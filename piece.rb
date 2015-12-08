require_relative 'board'
require_relative 'display'
require 'byebug'

class Piece
  ORTHOGONALS = [
    [1,0],
    [0,1],
    [-1,0],
    [0,-1]
  ]
  DIAGONALS = [
    [1,1],
    [1,-1],
    [-1,-1],
    [-1,1]
  ]
  L_MOVES = [
    [2,1],
    [1,2],
    [1,-2],
    [2,-1],
    [-2,1],
    [-1,2],
    [-1,-2],
    [-2,-1]
  ]

  attr_reader :color
  attr_accessor :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def to_s
    " x "
  end

  def move_into_check?(move)
    board_copy = @board.dup
    board_copy.move(@pos, move)
    # if move == [5,2]
    #   d = Display.new(board_copy)
    #   d.render
    #   puts "this is a copy of the board with #{board_copy.to_cc(@pos)} moved to #{board_copy.to_cc(move)}"
    #   puts "#{@color} check is #{board_copy.in_check?(@color)}"
    #   debugger
    # end
    if board_copy.in_check?(@color)
      return true
    end
  end

  def dup(new_board)
    self.class.new(@color, @pos.dup, new_board)
  end

end

class SlidingPiece < Piece

  def all_moves

    all_moves = []

    self.deltas.each do |direction|
      move = @pos
      while @board.in_bounds?(move)
        move = move.map.with_index { |i,j| i + direction[j] }

        if @board.in_bounds?(move)
          if @board[move].nil?
            all_moves << move
          elsif @board[move].color != self.color
            all_moves << move
          end
        end

        break unless @board[move].nil?
      end
    end

    all_moves

  end

  def valid_moves

    valid_moves = self.all_moves

    valid_moves.reject! { |move| move_into_check?(move)}

    valid_moves
  end



end

class SteppingPiece < Piece

  def all_moves

    all_moves= []

    self.deltas.each do |direction|
      move = @pos
      move = move.map.with_index { |i,j| i + direction[j] }
      next unless @board.in_bounds?(move)
      all_moves << move if @board[move].nil? || @board[move].color != self.color
    end

    all_moves
  end


  def valid_moves

    valid_moves = self.all_moves

    valid_moves.reject! { |move| move_into_check?(move)}

    valid_moves
  end

end

class Bishop < SlidingPiece
  def deltas
    DIAGONALS
  end

  def to_s
    case @color
    when :white
      symbol = " \u2657 "
    when :black
      symbol = " \u265D "
    end
    symbol.encode('utf-8')
  end

end

class Queen < SlidingPiece
  def deltas
    ORTHOGONALS + DIAGONALS
  end

  def to_s
    case @color
    when :white
      symbol = " \u2655 "
    when :black
      symbol = " \u265B "
    end
    symbol.encode('utf-8')

  end
end

class Rook < SlidingPiece
  def deltas
    ORTHOGONALS
  end

  def to_s
    case @color
    when :white
      symbol = " \u2656 "
    when :black
      symbol = " \u265C "
    end
    symbol.encode('utf-8')
  end
end

class Knight < SteppingPiece
  def deltas
    L_MOVES
  end

  def to_s
    case @color
    when :white
      symbol = " \u2658 "
    when :black
      symbol = " \u265E "
    end
    symbol.encode('utf-8')

  end
end

class King < SteppingPiece
  def deltas
    ORTHOGONALS + DIAGONALS
  end

  def to_s
    case @color
    when :white
      symbol = " \u2654 "
    when :black
      symbol = " \u265A "
    end
    symbol.encode('utf-8')

  end
end

class Pawn < Piece


  def all_moves
    all_moves = []
    if self.color == :white
      possible_move = [pos[0]-1,pos[1]]
      if @board[possible_move].nil? && @board.in_bounds?(possible_move)
        all_moves << possible_move
        all_moves << [4, pos[1]] if self.pos[0] == 6 && @board[[4,pos[1]]].nil?
      end
      possible_moves = [[-1,-1],[-1,1]]
      possible_moves.each do |move|
        possible_move = pos.map.with_index {|i,j| i + move[j]}
        if @board.in_bounds?(possible_move) && !@board[possible_move].nil?
          all_moves << possible_move if @board[possible_move].color == :black
        end
      end

    elsif self.color == :black
      possible_move = [pos[0]+1,pos[1]]
      if @board[possible_move].nil? && @board.in_bounds?(possible_move)
        all_moves << possible_move
        all_moves << [3, pos[1]] if self.pos[0] == 1 && @board[[3,pos[1]]].nil?
      end
      possible_moves = [[1,1],[1,-1]]
      possible_moves.each do |move|
        possible_move = pos.map.with_index {|i,j| i + move[j]}
        if @board.in_bounds?(possible_move) && !@board[possible_move].nil?
          all_moves << possible_move if @board[possible_move].color == :white
        end
      end
    end

    all_moves

  end

  def valid_moves

    valid_moves = self.all_moves

    valid_moves.reject! { |move| move_into_check?(move) }
    valid_moves

  end

  def to_s
    case @color
    when :white
      symbol = " \u2659 "
    when :black
      symbol = " \u265F "
    end
    symbol.encode('utf-8')
  end
end

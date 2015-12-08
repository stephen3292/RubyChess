require_relative 'board'
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

  attr_reader :color, :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @moves = []
  end

  def to_s
    " x "
  end

end

class SlidingPiece < Piece

  def moves
    @moves = []

    self.deltas.each do |direction|
      move = @pos
      while @board.in_bounds?(move)
        move = move.map.with_index { |i,j| i + direction[j] }

        if @board.in_bounds?(move)
          if @board[move].nil?
            @moves << move
          elsif @board[move].color != self.color
            @moves << move
          end
        end

        break unless @board[move].nil?
      end
    end

    @moves
  end



end

class SteppingPiece < Piece

  def moves
    @moves = []

    self.deltas.each do |direction|
      move = @pos
      move = move.map.with_index { |i,j| i + direction[j] }
      next unless @board.in_bounds?(move)
      @moves << move if @board[move].nil? || @board[move].color != self.color
    end

    @moves
  end

end

class Bishop < SlidingPiece
  def deltas
    DIAGONALS
  end

  def to_s
    " B "
  end

end

class Queen < SlidingPiece
  def deltas
    ORTHOGONALS + DIAGONALS
  end

  def to_s
    " Q "
  end
end

class Rook < SlidingPiece
  def deltas
    ORTHOGONALS
  end

  def to_s
    " R "
  end
end

class Knight < SteppingPiece
  def deltas
    L_MOVES
  end

  def to_s
    " N "
  end
end

class King < SteppingPiece
  def deltas
    ORTHOGONALS + DIAGONALS
  end

  def to_s
    " K "
  end
end

class Pawn < Piece
  def moves
    @moves = []
    if self.color == :blue
      possible_move = [pos[0]-1,pos[1]]
      if @board[possible_move].nil? && @board.in_bounds?(possible_move)
        @moves << possible_move
        @moves << [5, pos[1]] if self.pos[0] == 7 && @board[[5,pos[1]]].nil?
      end
      possible_moves = [[-1,-1],[-1,1]]
      possible_moves.each do |move|
        possible_move = pos.map.with_index {|i,j| i + move[j]}
        if @board.in_bounds?(possible_move) && !@board[possible_move].nil?
          @moves << possible_move if @board[possible_move].color == :black
        end
      end

    elsif self.color == :black
      possible_move = [pos[0]+1,pos[1]]
      if @board[possible_move].nil? && @board.in_bounds?(possible_move)
        @moves << possible_move
        @moves << [3, pos[1]] if self.pos[0] == 1 && @board[[3,pos[1]]].nil?
      end
      possible_moves = [[1,1],[1,-1]]
      possible_moves.each do |move|
        possible_move = pos.map.with_index {|i,j| i + move[j]}
        if @board.in_bounds?(possible_move) && !@board[possibl_move].nil?
          @moves << possible_move if @board[possible_move].color == :blue
        end
      end
    end
    @moves

  end

  def to_s
    " p "
  end
end

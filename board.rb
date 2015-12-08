require_relative 'piece'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate_board
  end

  def populate_board
    pieces_major = [:rook, :knight, :bishop, :queen, :king, :bishop, :knight, :rook]
    pieces_major.each_with_index do |piece, i|
      case piece
      when :rook
        self[[0,i]] = Rook.new(:black, [0,i], self)
        self[[7,i]] = Rook.new(:blue, [7,i], self)
      when :knight
        self[[0,i]] = Knight.new(:black, [0,i], self)
        self[[7,i]] = Knight.new(:blue, [7,i], self)
      when :bishop
        self[[0,i]] = Bishop.new(:black, [0,i], self)
        self[[7,i]] = Bishop.new(:blue, [7,i], self)
      when :queen
        self[[0,i]] = Queen.new(:black, [0,i], self)
        self[[7,i]] = Queen.new(:blue, [7,i], self)
      when :king
        self[[0,i]] = King.new(:black, [0,i], self)
        self[[7,i]] = King.new(:blue, [7,i], self)
      end
      self[[1,i]] = Pawn.new(:black, [1,i], self)
      self[[6,i]] = Pawn.new(:blue, [6,i], self)
    end
  end

  def []=(pos, piece)
    row,col = pos
    @grid[row][col] = piece
  end

  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def move(start, end_pos)
    raise "no piece at start of move" if self[start].nil?
    raise "piece can't move that way" if self[start].allowable_move?(end_pos)
    self[end_pos] = self[start_pos]
  end


end

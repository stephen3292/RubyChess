require_relative 'piece'
require_relative 'display'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(empty = false)
    @grid = Array.new(8) { Array.new(8) }
    populate_board unless empty
  end

  def populate_board
    pieces_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    pieces_classes.each_with_index do |piece_class, i|
      self[[0,i]] = piece_class.new(:black, [0,i], self)
      self[[7,i]] = piece_class.new(:white, [7,i], self)

      self[[1,i]] = Pawn.new(:black, [1,i], self)
      self[[6,i]] = Pawn.new(:white, [6,i], self)
    end
  end

  def []=(pos, piece)
    row,col = pos
    @grid[row][col] = piece
  end

  def [](pos)
    row,col = pos
    if @grid[row].nil?
      return nil
    else
      @grid[row][col]
    end
  end

  def checkmate?(color)
    checkmate = true
    self.pieces.each do |piece|
      checkmate = false if piece.color == color && piece.valid_moves.size > 0
    end
    return checkmate

  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def valid_piece?(pos, color)
    if self[pos].nil?
      puts "No piece at that position."
      sleep(0.5)
      return false
    elsif self[pos].color == color
      return true
    end
    puts "Wrong color piece at that position."
    sleep(0.5)
    return false
  end

  def valid_move?(piece_pos, end_pos)
    if self[piece_pos].valid_moves.include?(end_pos)
      puts "Moving #{self[piece_pos].class} to #{to_cc(end_pos)}."
      sleep(0.5)
      true
    else
      puts "Invalid move."
      sleep(0.5)
      false
    end
  end

  def in_check?(color)
    king_pos = []
    self.pieces.each do |piece|
      if piece.is_a?(King) && piece.color == color
        king_pos = piece.pos
      end
    end

    self.pieces.each do |piece|
      if piece.color != color
        piece.all_moves.each { |move| return true if move == king_pos }
      end
    end

    false
  end

  def move(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = nil
  end

  def to_cc(arr)
    return arr unless arr.count == 2
    coords = "ABCDEFGH"
    return "#{coords[arr[1]]}#{arr[0] + 1}"
  end

  def dup
    copy = Board.new(true)
    self.pieces.each do |piece|
      copy[piece.pos] = piece.dup(copy)
    end
    copy
  end

  def pieces
    @grid.flatten.compact
  end

end

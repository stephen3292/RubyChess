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
    if @grid[row].nil?
      return nil
    else
      @grid[row][col]
    end
  end

  def checkmate?
    false
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def valid_piece?(pos, color)
    if self[pos].nil?
      puts "No piece at that position."
      sleep(1)
      return false
    elsif self[pos].color == color
      return true
    end
    puts "Wrong color piece at that position."
    sleep(1)
    return false
  end

  def valid_move?(piece_pos, end_pos)
    if self[piece_pos].moves.include?(end_pos)
      puts "Moving #{self[piece_pos].class} to #{to_cc(end_pos)}."
      sleep(1)
      true
    else
      puts "Invalid move."
      sleep(1)
      false
    end
  end


  def move(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = nil
  end

  def to_cc(arr)
    return arr unless arr.count == 2
    coords = "ABCDEFGH"
    return "#{coords[arr[0]]}#{arr[1]}"
  end


end

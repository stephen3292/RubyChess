
require_relative 'board'
require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = nil
  end

  def colors_for(i,j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif [i, j] == @selected
      bg = :green
    elsif (i + j).odd?
      bg = :white
    else
      bg = :grey
    end
    text_color = ( (@board[[i,j]].nil?) ? :white : @board[[i,j]].color )


    { background: bg, color: text_color }
  end

  def select_piece(pos)
    @selected = pos
  end


  def rendered_board
    @board.grid.map.with_index do |row, i|
      row.map.with_index do |square, j|
        color_options = colors_for(i, j)
        if square.nil?
          "   ".colorize(color_options)
        else
          square.to_s.colorize(color_options)
        end
      end
    end
  end

  def render
    system("clear")
    rendered_board.each { |row| puts row.join }
    nil
  end



end

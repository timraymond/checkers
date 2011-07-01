module Checkers
  class Game
    attr_reader :players, :board

    def initialize
      @players = {dark: Checkers::Player.new(:dark), light: Checkers::Player.new(:light)}
      @board = Board.new

      #assign pieces for dark player
      @players[:dark].pieces.each_index do |i|
        cell = case i
        when 0
          "c1:r1"
        when 1
          "c3:r1"
        when 2
          "c5:r1"
        when 3
          "c7:r1"
        when 4
          "c2:r2"
        when 5
          "c4:r2"
        when 6
          "c6:r2"
        when 7
          "c8:r2"
        when 8
          "c1:r3"
        when 9
          "c3:r3"
        when 10
          "c5:r3"
        when 11
          "c7:r3"
        end
        @board.cells[cell][:piece] = @players[:dark].pieces[i]
      end

      #assign pieces for light player
      @players[:light].pieces.each_index do |i|
        cell = case i
        when 0
          "c2:r8"
        when 1
          "c4:r8"
        when 2
          "c6:r8"
        when 3
          "c8:r8"
        when 4
          "c1:r7"
        when 5
          "c3:r7"
        when 6
          "c5:r7"
        when 7
          "c7:r7"
        when 8
          "c2:r6"
        when 9
          "c4:r6"
        when 10
          "c6:r6"
        when 11
          "c8:r6"
        end
        @board.cells[cell][:piece] = @players[:light].pieces[i]
      end

    end

    def dark_player
      @players[:dark]
    end

    def light_player
      @players[:light]
    end

    def make_move(player, from_cell_index, to_cell_index)
      return unless is_move_valid?(player, from_cell_index, to_cell_index)

    end

    def is_move_valid?(player, from_cell_index, to_cell_index)
      from_cell = @board[from_cell_index]
      to_cell = @board[to_cell_index]

      if to_cell[:peice]
        #special logic if the cell
        allowed_cols = [from_cell[:col] - 2,  from_cell[:col] + 2]
        allowed_row  = from_cell[:row] + 2
      else
        #it is a blank cell there are only two valid options
        allowed_cols = [from_cell[:col] - 1,  from_cell[:col] + 1]
        allowed_row  = from_cell[:row] + 1
      end

      allowed_cols.delete_if {|col| col < 1 || col > 8}

      allowed_cols.select {|col| col == to_cell[:col]}.count > 0 && allowed_row == to_cell[:row]
    end
  end
end
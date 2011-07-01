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
      from_cell = @board.cells[from_cell_index]
      return if from_cell[:piece].nil?

      to_cell = @board.cells[to_cell_index]
      return unless to_cell[:color] == :dark

      to_cell[:piece]   = from_cell[:piece]
      from_cell[:piece] = nil

      to_cell
    end

    def is_move_valid?(player, from_cell_index, to_cell_index)
      from_cell = @board.cells[from_cell_index]
      return if from_cell.nil?
      return if from_cell[:piece].nil?

      return unless from_cell[:piece].color == player.color

      to_cell = @board.cells[to_cell_index]
      return if to_cell.nil?
      return unless to_cell[:piece].nil?
      return unless to_cell[:color] == :dark

      move_direction = if player.color == :dark
        :+
      else
        :-
      end

      if to_cell[:peice]
        column_change = 2
        allowed_cols = [from_cell[:column] - 2,  from_cell[:column] + 2]
        allowed_row  = from_cell[:row].send(move_direction, 2)
      else
        column_change = 1
        #it is a blank cell there are only two valid options
        allowed_cols = [from_cell[:column] - 1,  from_cell[:column] + 1]
        allowed_row  = from_cell[:row].send(move_direction, 1)
      end

      allowed_cols.delete_if {|col| col < 1 || col > 8}

      allowed_cols.select {|col| col == to_cell[:column]}.count > 0 && allowed_row == to_cell[:row]
    end
  end
end
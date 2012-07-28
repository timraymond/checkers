module Checkers
  class Move
    def initialize(board, player, from_cell_index, to_cell_index)
      @board = board
      @player = player
      @from_cell_index = from_cell_index
      @to_cell_index = to_cell_index
      @from_cell = board.cells[from_cell_index]
      @to_cell = board.cells[to_cell_index]
    end

    def valid?
      @from_cell = @board.cells[@from_cell_index]
      return if @from_cell.nil?
      return if @from_cell[:piece].nil?

      return unless @from_cell[:piece].color == @player.color

      @to_cell = @board.cells[@to_cell_index]
      return if @to_cell.nil?
      return unless @to_cell[:piece].nil?
      return unless @to_cell[:color] == :dark

      y_direction = if @player.color == :dark
        :+
      else
        :-
      end

      x_direction = if @to_cell[:column] < @from_cell[:column]
        :-
      else
        :+
      end

      allowed_cols = []
      allowed_row = nil

      if (@to_cell[:column] - @from_cell[:column]).abs == 2 && (@to_cell[:row] - @from_cell[:row]).abs == 2
        #capture
        jumped_piece = @board.cells["c#{@from_cell[:column].send(x_direction, 1)}:r#{@from_cell[:row].send(y_direction, 1)}"][:piece]
        if jumped_piece && jumped_piece.color != @player.color
          allowed_cols << @from_cell[:column].send(x_direction, 2)
          allowed_row = @from_cell[:row].send(y_direction, 2)
        end
      else
        column_change = 1
        #it is a blank cell there are only two valid options
        allowed_cols = [@from_cell[:column] - 1,  @from_cell[:column] + 1]
        allowed_row  = @from_cell[:row].send(y_direction, 1)
      end

      allowed_cols.delete_if {|col| col < 1 || col > 8}

      allowed_cols.select {|col| col == @to_cell[:column]}.count > 0 && allowed_row == @to_cell[:row]
    end

    def execute
      return unless valid?
      @to_cell[:piece], @from_cell[:piece] = @from_cell[:piece], nil
      @to_cell
    end
  end
end

module Checkers
  class Board
    def initialize
      @cells = {}
      (1..8).each do |row|
        cell_color = if row.odd?
          :light
        else
          :dark
        end
        (1..8).each do |col|
          cell_color = if cell_color == :dark
            :light
          else
            :dark
          end
          @cells["c#{col.to_s}:r#{row.to_s}"] = {color: cell_color, piece: nil, row: row, column: col}
        end
      end
    end

    def cells
      @cells
    end
  end
end
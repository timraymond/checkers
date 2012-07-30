module Checkers
  class Board
    def initialize(ctp_board = "bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww")
      @cells = []
      # Anything longer than 32 chars is garbage,
      # so input is sliced accordingly
      ctp_board[0..31].each_char do |cell_value|
        case cell_value
        when 'b'
          @cells << Piece.new(:black)
        when 'B'
          @cells << King.new(:black)
        when 'w'
          @cells << Piece.new(:white)
        when 'W'
          @cells << King.new(:white)
        when 'x'
          @cells << nil
        else
          raise "CTP Parse Error"
        end
      end
    end

    def [](idx)
      return nil if idx > 32 || idx < 1
      @cells[idx-1]
    end

    def []=(idx, item)
      @cells[idx-1] = item
    end

    def clone
      Board.new(self.to_s) # Deep copy
    end

    def count_pieces(color)
      @cells.inject(0) do |count, cell|
        return count if cell.nil?
        if cell.color == color
          count + 1
        else
          count
        end
      end
    end
#      @cells = {}
#      (1..8).each do |row|
#        cell_color = if row.odd?
#          :light
#        else
#          :dark
#        end
#        (1..8).each do |col|
#          cell_color = if cell_color == :dark
#            :light
#          else
#            :dark
#          end
#          @cells["c#{col.to_s}:r#{row.to_s}"] = {color: cell_color, piece: nil, row: row, column: col}
#        end
#      end
#    end

    def cells
      @cells
    end

    def neighbors(location)
      return nil if location.nil?
      idx = location-1 # align with array
      neighbors = [
        ####### row 1 #####
        {ne: 5, nw: 6}, # 1
        {ne: 6, nw: 7}, # 2
        {ne: 7, nw: 8}, # 3
        {ne: 8},        # 4
        ####### row 2 #####
        {nw: 9, sw: 1}, # 5
        {ne: 9, nw: 10, sw: 2, se: 1},  # 6
        {ne: 10, nw: 11, sw: 3, se: 2}, # 7
        {ne: 11, nw: 12, sw: 4, se: 3}, # 8
        ####### row 3 ####################
        {ne: 13, nw: 14, sw: 6, se: 5}, # 9
        {ne: 14, nw: 15, sw: 7, se: 6}, # 10
        {ne: 15, nw: 16, sw: 8, se: 7}, # 11
        {ne: 16, se: 8},                # 12
        ####### row 4 ####################
        {nw: 17, sw: 9},                # 13
        {ne: 17, nw: 18, sw: 10, se: 9},# 14
        {ne: 18, nw: 19, sw: 11, se: 10}, # 15
        {ne: 19, nw: 20, sw: 12, se: 11}, # 16
        ####### row 5 ####################
        {ne: 21, nw: 22, sw: 14, se: 13}, # 17
        {ne: 22, nw: 23, sw: 15, se: 14}, # 18
        {ne: 23, nw: 24, sw: 16, se: 15}, # 19
        {ne: 24, se: 16},                 # 20
        ####### row 6 ####################
        {nw: 25, sw: 17},                 # 21
        {ne: 25, nw: 26, sw: 18, se: 17}, # 22
        {ne: 26, nw: 27, sw: 19, se: 18}, # 23
        {ne: 27, nw: 28, sw: 20, se: 19}, # 24
        ###### row 7 #####################
        {ne: 29, nw: 30, sw: 22, se: 21}, # 25
        {ne: 30, nw: 31, sw: 23, se: 22}, # 26
        {ne: 31, nw: 32, sw: 24, se: 23}, # 27
        {ne: 32, se: 24},                 # 28
        ###### row 8 #####################
        {sw: 25},                         # 29
        {sw: 26, se: 25},                 # 30
        {sw: 27, se: 26},                 # 31
        {sw: 28, se: 27},                 # 32
      ]

      neighbors[idx]
    end

    def to_s
      ctp_board = ""
      @cells.each do |cell|
        if cell.class == Checkers::King
          if cell.color == :white
            ctp_board << 'W'
          else
            ctp_board << 'B'
          end
        elsif cell.nil?
          ctp_board << 'x'
        else
          if cell.color == :white
            ctp_board << 'w'
          else
            ctp_board << 'b'
          end
        end
      end
      ctp_board
    end
  end
end

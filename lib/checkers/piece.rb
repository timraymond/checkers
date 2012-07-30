module Checkers
  class Piece
    attr_reader :color, :moves

    def initialize(color)
      @color = color
      case color
      when :black
        @moves = [:ne, :nw]
      when :white
        @moves = [:sw, :se]
      end
    end
  end
end

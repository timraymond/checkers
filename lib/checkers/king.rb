module Checkers
  class King
    attr_reader :color, :moves

    def initialize(color)
      @color = color
      @moves = [:ne, :nw, :sw, :se]
    end
  end
end

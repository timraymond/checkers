module Checkers
  class Player
    attr_reader :color, :pieces
    attr_accessor :captured_pieces

    def initialize(color)
      @color = color
      @pieces = (1..12).inject([]) {|array| array << Piece.new(color)}
      @captured_pieces = []
    end
  end
end
module Checkers
  class Move
    attr_reader :src_idx, :dest_idx
    alias src   src_idx
    alias dest  dest_idx

    def initialize(board, src_idx, dest_idx)
      @board = board
      @src_idx = src_idx
      @dest_idx = dest_idx
      @owner = board[src_idx].color
    end

    def valid?
      return nil if @board[@src_idx].nil?
      valid_moves = 
        [true, false, false, false]

      neighbor = ordinalize(@src_idx, @dest_idx)

      valid_moves[neighbor] && @board[@src_idx].moves.map { |dir| @board.neighbors(@src_idx)[dir] }.include?(@dest_idx)
    end

    def execute
      return unless valid?
      @board[@dest_idx] = @board[@src_idx]
      @board[@src_idx]  = nil
      @board
    end

    def revert
      return unless valid?
      @board[@dest_idx], @board[@src_idx] = nil, @board[@dest_idx]
      @board
    end

    def owner
      @owner
    end

    def to_s
      "#{@src_idx}x#{@dest_idx}"
    end

  private
    
    def ordinalize(reference, subject)
      return 3 if subject.nil? # Invalid space
      return 0 if @board[subject].nil?
      return 1 if @board[reference].color == @board[subject].color
      return 2 if @board[reference].color != @board[subject].color
    end
  end
end

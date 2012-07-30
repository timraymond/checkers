module Checkers
  class Jump < Move
    def initialize(board, src_idx, jump_idx, dest_idx)
      @jump_idx = jump_idx
      super(board, src_idx, dest_idx)
    end

    def valid?
      valid_moves =
        [[false, false, false, false],
         [false, true,  false, false],
         [false, false, false, false]]

      jumped = ordinalize(@src_idx, @jump_idx)
      dest   = ordinalize(@src_idx, @dest_idx)

      valid_moves[jumped][dest]
    end

    def execute
      @jumped_piece = @board[@jump_idx]
      @board[@jump_idx] = nil
      super
    end

    def revert
      @board[@jump_idx] = @jumped_piece
      super
    end
  end
end

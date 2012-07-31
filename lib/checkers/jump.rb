module Checkers
  class Jump < Move
    def initialize(board, src_idx, jump_idx, dest_idx)
      @jump_idx = jump_idx
      super(board, src_idx, dest_idx)
    end

    def valid?
      valid_moves =
        [[false, false, false, false],
         [false, false, false, false],
         [true,  false, false, false],
         [false, false, false, false]]

      jumped = ordinalize(@src_idx, @jump_idx)
      dest   = ordinalize(@src_idx, @dest_idx)

      valid_moves[jumped][dest] && forms_chain(@src_idx, @jump_idx, @dest_idx)
    end

    def execute
      return nil unless valid?
      @board[@dest_idx] = @board[@src_idx]
      @board[@src_idx]  = nil

      @jumped_piece     = @board[@jump_idx]
      @board[@jump_idx] = nil
      @board
    end

    def revert
      @board[@jump_idx] = @jumped_piece
    end

  private

    def forms_chain(cell1, cell2, cell3)
      piece_moves = @board[cell1].moves
      next_to_1   = @board.neighbors(cell1)
      next_to_2   = @board.neighbors(cell2)

      # Strip out any directions that the piece can't move in
      next_to_1.delete_if { |dir, cell| !piece_moves.include? dir }
      next_to_2.delete_if { |dir, cell| !piece_moves.include? dir }

      # Get the direction of cell2
      direction = next_to_1.invert[cell2]
      return nil if direction.nil?

      # Fail if cell3 is not next to 2 in the direction of cell1
      cell3 == next_to_2[direction]
    end
  end
end

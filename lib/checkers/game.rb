module Checkers
  class Game
    attr_reader :current_player, :players, :board

    def initialize
      @players = [:black, :white]
      @board = Board.new
      @current_player = @players.sample # Random starting player
      @moves = []
    end

    def self.from_text(ctp_game_text)
      game_opts = ctp_game_text.split ':'
      ctp_board = game_opts.shift
      ctp_player = game_opts.shift

      game = self.new
      game.instance_eval { 
        @board = Board.new(ctp_board)
        @current_player = if ctp_player == 'b'
                            :black
                          elsif ctp_player == 'w'
                            :white
                          else
                            raise "CTP Parse Error"
                          end
      }
      game
    end

    def commit_move(move)
      return nil unless move.valid?
      return nil if move.owner != @current_player
      @moves << move
      @board = move.execute
      coronate_pieces()
      swap_players() unless jumps_available(move.dest)
      @current_player
    end

    # Returns available moves or jumps for current_player
    def options
      pieces = @board.pieces(@current_player)
      moves = []
      pieces.each do |location|
        piece = @board[location]
        piece.moves.each do |direction|
          neighbor1 = @board.neighbors(location)[direction] if @board.neighbors(location)
          neighbor2 = @board.neighbors(neighbor1)[direction] if @board.neighbors(neighbor1)
          moves << move_factory(location, neighbor1, neighbor2)
        end
      end
      moves.delete_if(&:nil?)

      if moves.map(&:class).include?(Checkers::Jump)
        moves.delete_if { |move| move.class == Checkers::Move }
        unless @moves.empty? || @current_player != @moves.last.owner
          # There are still jumps leftover
          moves.keep_if { |jump| jump.src == @moves.last.dest }
        end
      end
      
      moves
    end

    def over?
      # Game is over when one player has no pieces
      @board.count_pieces(:black) == 0 || @board.count_pieces(:white) == 0
    end

    def to_s
      player = if @current_player == :black then 'b' else 'w' end
      [@board.to_s, player].join ':'
    end
  private

    def move_factory(src_idx, neighbor1, neighbor2)
      move = build_jump(src_idx, neighbor1, neighbor2)
      move = build_move(src_idx, neighbor1) unless move.valid?
      move = nil unless move.valid?
      move
    end

    def swap_players
      @current_player = if @current_player == :white
                          :black
                        else
                          :white
                        end
    end

    def build_move(src_idx, dest_idx)
      Checkers::Move.new(@board.clone, src_idx, dest_idx)
    end

    def build_jump(src_idx, jump_idx, dest_idx)
      Checkers::Jump.new(@board.clone, src_idx, jump_idx, dest_idx)
    end

    def coronate_pieces
      [1, 2, 3, 4].each do |back_cell|
        if @board[back_cell].color == :white
          @board[back_cell] = Checkers::King.new(:white)
        end
      end
      [32, 31, 30, 29].each do |back_cell|
        if @board[back_cell].color == :black
          @board[back_cell] = Checkers::King.new(:black)
        end
      end
    end

    def jumps_available(location)
      jumps = options.delete_if { |move| move.class != Checkers::Jump }
      jumps.delete_if { |jump| jump.src != location }.size > 0
    end
  end
end

module Checkers
  class Game
    attr_reader :current_player, :players, :board

    def initialize
      @players = [:black, :white]
      @board = Board.new
      @current_player = @players.sample # Random starting player
    end

    def self.from_text(ctp_board, ctp_player)
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
      return nil if move.invalid?
      return nil if move.owner != @current_player
      @moves << move
      @board = move.execute
      swap_players()
    end

    # Returns available moves or jumps for current_player
    def options
    end

    def over?
      # Game is over when one player has no pieces
      @board.count_pieces(:black) == 0 || @board.count_pieces(:white) == 0
    end

  private

    def move_factory(src_idx, neighbor1, neighbor2)
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

    def build_jump(src_idx, dest_idx, jump_idx)
      Checkers::Jump.new(@board.clone, src_idx, dest_idx, jump_idx)
    end
  end
end

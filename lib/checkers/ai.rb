module Checkers
  class AI
    def initialize(game_state, opts = {})
      @engine = game_state
      @my_color = @engine.current_player
      @@max_depth = 4

      @@alpha_beta = if opts.has_key?(:alpha_beta)
                       opts[:alpha_beta]
                     else
                       false
                     end
      @@debug = if opts.has_key?(:debug)
                  opts[:debug]
                else
                  false
                end
    end

    def evaluate(board = @engine.board)
      black = board.count_pieces(:black)
      white = board.count_pieces(:white)
      value = black - white
      value = 4000 if white == 0
      value = -4000 if black == 0
      value = value * -1 if @my_color == :white
      value
    end

    def choose
      magic = rand(256)
      debug "Hey there! My number is #{magic}"
      debug "#{magic}: My options at depth: #{@engine.moves.count}: #{@engine.options.join ","}"
      opts = @engine.options
      ranked_options = []
      opts.each do |move|
        debug "#{magic}: Round the block again"
        rank = rank(move)
        debug "#{magic}: woahoah! We've got a rank of #{rank.rank}"
        ranked_options << rank
      end
      debug "#{magic} My choice at depth: #{@engine.moves.count}: #{ranked_options.max}"

      ranked_options.max # Return the best move
    end

    def abrank(move, alpha, beta)
      @engine.commit_move(move)
      if @engine.moves.count == @@max_depth
        result = evaluate()
        return result
      else
        @engine.options.each do |move|
          score = -1 * abrank(move, (beta * -1), (alpha * -1))
          @engine.rollback
          if score >= beta
            return beta;
          elsif score > alpha
            alpha = score
          end
        end
      end

      return alpha
    end
    def random_choice
      @engine.options.sample
    end

    def rank(move)
      if @@alpha_beta
        move.rank = abrank(move, -4000, 4000)
        return move
      end

      if @engine.moves.count == @@max_depth
        move.rank = evaluate(move.execute)
      else
        debug "Committing #{move}"
        @engine.commit_move(move)
        debug "Spawning somebody new! at level #{@engine.moves.count}"
        responder = Checkers::AI.new(@engine)
        response = responder.choose
        debug "I've got the response, here it is: #{response}"
        @engine.rollback
        move.rank = response.rank * -1 # Inversion of color
      end
      debug "Returning it on up, it's worth #{move.rank}"
      move
    end

    private

    def debug(msg)
      puts "DEBUG: #{msg}" if @@debug
    end
  end
end

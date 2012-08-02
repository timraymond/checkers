module Checkers
  class AI
    def initialize(game_state)
      @engine = Checkers::Game.from_text(game_state)
      @my_color = @engine.current_player
    end

    def evaluate
      value = @engine.board.count_pieces(:black) - @engine.board.count_pieces(:white)
      value = value * -1 if @my_color == :white
      value
    end
  end
end

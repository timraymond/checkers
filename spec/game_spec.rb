require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Game do
  it "should determine when the game is over" do
    game = Checkers::Game.from_text("xxxxWWWxxxxxxxxxxxxxxxxxxxxxxxxx", 'b')
    game.should be_over

    game = Checkers::Game.from_text("xxxxBBBxxxxxxxxxxxxxxxxxxxxxxxxx", 'w')
    game.should be_over
  end
end

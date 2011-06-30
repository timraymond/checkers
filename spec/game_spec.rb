require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Game do
  it "must have two players" do
    game = Checkers::Game.new
    game.players.count.should == 2
  end

  it "must give each player 12 peices" do

  end
end
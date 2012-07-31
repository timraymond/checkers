require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Piece do
  it "should know which directions it can move based on its color" do
    white = Checkers::Piece.new(:white)
    black = Checkers::Piece.new(:black)

    white.moves.should == [:sw, :se]
    black.moves.should == [:ne, :nw]
  end

end

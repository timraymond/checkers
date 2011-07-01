require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Player do
  it "should have 12 pieces" do
    player = Checkers::Player.new(:dark)
    player.pieces.count.should == 12
  end

  it "should have no captured pieces" do
    player = Checkers::Player.new(:dark)
    player.captured_pieces.count.should == 0
  end

  it "should have all pieces in the same color" do
    player = Checkers::Player.new(:dark)
    player.pieces.each do |piece|
      piece.color.should == :dark
    end
  end
end
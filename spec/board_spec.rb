require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Board do
  it "should have 64 spaces" do
    board = Checkers::Board.new
    board.cells.count.should == 64
  end
end
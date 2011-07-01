require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Board do
  it "should have 64 spaces" do
    board = Checkers::Board.new
    board.cells.count.should == 64
  end

  it "should have the first cell as dark" do
    board = Checkers::Board.new
    board.cells["c1:r1"][:color].should == :dark
  end

  it "should have the last cell as dark" do
    board = Checkers::Board.new
    board.cells["c8:r8"][:color].should == :dark
  end

  it "should have 8 rows" do
    board = Checkers::Board.new
    (1..8).each do |i|
      board.cells["c1:r#{i}"].should.class == Hash
    end
  end

  it "should have 8 columns" do
    board = Checkers::Board.new
    (1..8).each do |i|
      board.cells["c#{i}:r1"].should.class == Hash
    end
  end
end
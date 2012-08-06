require 'spec_helper'

describe Checkers::Board do
  it "should have 32 available cells" do
    board = Checkers::Board.new
    cells = board.instance_eval { @cells }
    cells.size.should == 32
  end

  it "should have 12 black pieces" do
    board = Checkers::Board.new
    board.count_pieces(:black).should == 12
  end

  it "should have 12 white pieces" do
    board = Checkers::Board.new
    board.count_pieces(:white).should == 12
  end

  it "should have a text representation" do
    board = Checkers::Board.new
    board.to_s.should == "bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww"
  end

  it "should allow access with PDN notation" do
    board = Checkers::Board.new
    board[12].color.should == :black
    board[21].color.should == :white
  end

  it "should return nil for bad PDN access" do
    board = Checkers::Board.new
    board[33].should be_nil
    board[-1].should be_nil
  end

  it "should allow assigning pieces to PDN locations" do
    board = Checkers::Board.new
    board[1] = Checkers::Piece.new(:white)
    board[1].color.should == :white
  end

  it "should return the locations of pieces of a particular color" do
    board = Checkers::Board.new
    board.pieces(:black).inject(:+).should == (12*13)/2
  end

  describe "neighbors" do
    it "is nil for a nil cell argument" do
      board = Checkers::Board.new
      board.neighbors(nil).should be_nil
    end

    it "should have proper diagonal sums" do
      # If this is truly working correctly, the diagonals will sum
      # to known values
      board = Checkers::Board.new

      expected_ne = [6, 30, 72, 132, 126, 102, 60]
      start_ne    = [1, 2, 3, 4, 12, 20, 28]

      expected_nw = [4, 23, 56, 103, 128, 109, 76, 29]
      start_nw    = [4, 3, 2, 1, 5, 13, 21, 29]

      expected_se = [29, 76, 109, 128, 103, 56, 23, 4]
      start_se    = [29, 30, 31, 32, 28, 20, 12, 4]

      expected_sw = [60, 102, 126, 132, 72, 30, 6]
      start_sw    = [32, 31, 30, 29, 21, 13, 5]

      # NE sums
      start_ne.each_with_index do |start_val, idx|
        sum = 0
        i = start_val
        while i
          sum = sum + i
          i = board.neighbors(i)[:ne]
        end
        sum.should == expected_ne[idx]
      end

      # NW sums
      start_nw.each_with_index do |start_val, idx|
        sum = 0
        i = start_val
        while i
          sum = sum + i
          i = board.neighbors(i)[:nw]
        end
        sum.should == expected_nw[idx]
      end

      # SW sums
      start_sw.each_with_index do |start_val, idx|
        sum = 0
        i = start_val
        while i
          sum = sum + i
          i = board.neighbors(i)[:sw]
        end
        sum.should == expected_sw[idx]
      end

      # SE sums
      start_se.each_with_index do |start_val, idx|
        sum = 0
        i = start_val
        while i
          sum = sum + i
          i = board.neighbors(i)[:se]
        end
        sum.should == expected_se[idx]
      end
    end
  end
end

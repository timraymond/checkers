require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Game do
  it "must have two players" do
    game = Checkers::Game.new
    game.players.count.should == 2
  end

  it "should have the first 12 dark slots filled with dark player's pieces" do
    game = Checkers::Game.new
    board = game.board
    board.cells["c1:r1"][:piece].color.should == :dark
    board.cells["c3:r1"][:piece].color.should == :dark
    board.cells["c5:r1"][:piece].color.should == :dark
    board.cells["c7:r1"][:piece].color.should == :dark

    board.cells["c2:r2"][:piece].color.should == :dark
    board.cells["c4:r2"][:piece].color.should == :dark
    board.cells["c6:r2"][:piece].color.should == :dark
    board.cells["c8:r2"][:piece].color.should == :dark

    board.cells["c1:r3"][:piece].color.should == :dark
    board.cells["c3:r3"][:piece].color.should == :dark
    board.cells["c5:r3"][:piece].color.should == :dark
    board.cells["c7:r3"][:piece].color.should == :dark
  end

  it "should have the last 12 dark slots filled with light player's pieces" do
    game = Checkers::Game.new
    board = game.board
    board.cells["c2:r8"][:piece].color.should == :light
    board.cells["c4:r8"][:piece].color.should == :light
    board.cells["c6:r8"][:piece].color.should == :light
    board.cells["c8:r8"][:piece].color.should == :light

    board.cells["c1:r7"][:piece].color.should == :light
    board.cells["c3:r7"][:piece].color.should == :light
    board.cells["c5:r7"][:piece].color.should == :light
    board.cells["c7:r7"][:piece].color.should == :light

    board.cells["c2:r6"][:piece].color.should == :light
    board.cells["c4:r6"][:piece].color.should == :light
    board.cells["c6:r6"][:piece].color.should == :light
    board.cells["c8:r6"][:piece].color.should == :light
  end

  it "should only have pieces on dark slots" do
    game = Checkers::Game.new
    board = game.board
    board.cells.each do |k, cell|
      if cell[:piece]
        cell[:color].should == :dark
      end
    end
  end

  it "should allow a move to a dark empty cell" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    game.is_move_valid?(dark_player, "c1:r3", "c2:r4").should == true
  end

  it "should error when moving to an occupied cell" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    game.is_move_valid?(dark_player, "c1:r3", "c2:r4").should == true
  end
end
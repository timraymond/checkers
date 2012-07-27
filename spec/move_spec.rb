require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Move do
  it "should properly validate the dark_player move to an empty cell" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    move = game.move(dark_player, "c1:r3", "c2:r4")
    move.valid?.should == true
  end
  it "should properly validate the light_player move to an empty cell" do
    game = Checkers::Game.new
    light_player = game.players[:light]
    move = game.move(light_player, "c2:r6", "c1:r5")
    move.valid?.should == true
  end

  it "should not be valid to move from an unoccupied cell" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    move = game.move(light_player, "c1:r2", "c2:r3")
    move.valid?.should_not == true
  end

  it "should not be valid to move to an occupied cell" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    move = game.move(dark_player, "c1:r1", "c2:r2")
    move.valid?.should_not == true
  end

  it "should make a move if the move is valid" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    move = game.move(dark_player, "c1:r3", "c2:r4")
    move.execute.should_not be_nil

    game.board.cells["c2:r4"][:piece].should_not be_nil
    game.board.cells["c1:r3"][:piece].should be_nil
  end

  it "should not allow dark player to move light chips" do
    game = Checkers::Game.new
    dark_player = game.players[:dark]
    move = game.move(dark_player, "c2:r6", "c1:r5")
    move.valid?.should_not == true
    move = game.move(dark_player, "c1:r5", "c2:r6")
    move.valid?.should_not == true
  end
end

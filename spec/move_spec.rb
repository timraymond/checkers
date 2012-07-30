require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Move do

  it "should have an owner based on the source piece" do
    game = Checkers::Game.new
    board = game.instance_eval { @board }
    move = Checkers::Move.new(board, 12, 16)
    move.owner.should == :black
  end

  it "should properly execute a valid move" do
    game = Checkers::Game.new
    board = game.instance_eval { @board }
    move = Checkers::Move.new(board, 12, 16)

    expected_board = "bbbbbbbbbbbxxxxbxxxxwwwwwwwwwwww"
    move.execute.to_s.should == expected_board
  end

  it "should have a PDN text representation" do
    game = Checkers::Game.new
    board = game.instance_eval { @board }
    move = Checkers::Move.new(board, 12, 16)

    move.to_s.should == "12x16"
  end
end

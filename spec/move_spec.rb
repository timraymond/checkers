require 'spec_helper'

describe Checkers::Move do

  before do
    @game = Checkers::Game.new
    @board = @game.board
  end

  subject { @move }

  context "cells are not neighboring" do
    before { @move = @game.instance_eval { build_move(1,31) }}

    it      { should_not be_valid }
    specify { @move.execute.should be_nil }
  end

  context "cells are neighboring" do
    context "piece is able to move" do
      before { @move = @game.instance_eval { build_move(12,16) }}

      it      { should be_valid }
      specify { @move.execute.should_not be_nil }
    end

    context "piece is unable to move" do
      before { @move = @game.instance_eval { build_move(2,7) }}

      it      { should_not be_valid }
      specify { @move.execute.should be_nil }
    end
  end

  it "should have an owner based on the source piece" do
    move = Checkers::Move.new(@board, 12, 16)
    move.owner.should == :black
  end

  it "should maintain owner after executing the move" do
    move = Checkers::Move.new(@board, 12, 16)
    expected = move.owner
    @board = move.execute
    move.owner.should == expected
  end

  it "should properly execute a valid move" do
    move = Checkers::Move.new(@board, 12, 16)

    expected_board = "bbbbbbbbbbbxxxxbxxxxwwwwwwwwwwww"
    move.execute.to_s.should == expected_board
  end

  it "should have a PDN text representation" do
    move = Checkers::Move.new(@board, 12, 16)

    move.to_s.should == "12x16"
  end
end

require 'spec_helper'

describe Checkers::Game do
  subject { @game }

  context "with jumps available to black" do
    before { @game = Checkers::Game.from_text("bbbbbbbbbbbbxxxwxxxxwwwwwwwwwww:b") }

    it "should not have any moves present in options" do
      @game.options.map(&:class).include?(Checkers::Move).should be_false
    end
  end

  context "double jump available to black" do
    before { @game = Checkers::Game.from_text("bbbbbbbbbbbbxwwxxxxxxxwxxxxxxxxx:b") }

    it "should not change turns after executing the first jump" do
      @game.commit_move(@game.options[3]).should == :black
    end

    it "should not include any other jump after executing the first jump of a double jump" do
      @game.commit_move(@game.options[3])
      @game.options.size.should == 1
    end
  end
  it "should promote pieces of the opposing color upon reaching the back rank" do
    @game = Checkers::Game.from_text("xxxxwxxxxxxxxxbxxxxxxxxxxxxxxxxx:w")
    @game.commit_move(@game.options[0])
    @board = @game.instance_eval { @board }
    @board[1].class.should == Checkers::King
  end

  it "should determine when the game is over" do
    game = Checkers::Game.from_text("xxxxWWWxxxxxxxxxxxxxxxxxxxxxxxxx:b")
    game.should be_over

    game = Checkers::Game.from_text("xxxxBBBxxxxxxxxxxxxxxxxxxxxxxxxx:w")
    game.should be_over
  end

  it "should return available moves for the current player" do
    game = Checkers::Game.from_text("bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww:b")
    game.options.size.should == 7
  end

  it "should have a text representation" do
    game = Checkers::Game.from_text("bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww:b")
    game.to_s.should == "bbbbbbbbbbbbxxxxxxxxwwwwwwwwwwww:b"
  end

  # Bugfixes
  
  it "should switch player upon moving into a jump position" do
    game = Checkers::Game.from_text("bbbbxxbbxbxxbbxbbxxxxxxwwwwwwwww:w")
    move = game.options.select { |move| move.dest == 20 }
    game.commit_move(move.first)
    game.current_player.should == :black
  end

  describe "rollback" do
    it "should restore the game to its original state" do
      game = Checkers::Game.new
      expected = game.to_s
      game.commit_move(game.options[0])
      game.rollback
      game.to_s.should == expected
    end
  end
end

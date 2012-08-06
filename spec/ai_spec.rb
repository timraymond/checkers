require 'spec_helper'

describe Checkers::AI do
  describe "Evaluation" do
    context "in a situation favorable to black" do
      before do
        @black = Checkers::AI.new(Checkers::Game.from_text("bbbbbbbbbbbbxxxxxxxxxxwwwwwwwwww:b"))
        @white = Checkers::AI.new(Checkers::Game.from_text("bbbbbbbbbbbbxxxxxxxxxxwwwwwwwwww:w"))
      end

      specify { @white.evaluate.should be < 0 }
      specify { @black.evaluate.should be > 0 }
    end

    context "in a situation favorable to white" do
      before do
        @black = Checkers::AI.new(Checkers::Game.from_text("bbbbbbbbxxxxxwwwwxwwwwwwwwxxxxxx:b"))
        @white = Checkers::AI.new(Checkers::Game.from_text("bbbbbbbbxxxxxwwwwxwwwwwwwwxxxxxx:w"))
      end

      specify { @white.evaluate.should be > 0 }
      specify { @black.evaluate.should be < 0 }
    end
  end
end

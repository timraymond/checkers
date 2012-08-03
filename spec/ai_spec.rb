require File.expand_path('../../lib/checkers', __FILE__)

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

  describe "Choice" do
    context "with a single jump and a double jump available" do
      subject { @ai.choose.dest }
      before { @ai = Checkers::AI.new(Checkers::Game.from_text("bbbbbbbbbbbbxwwxxxxxxxwxxxxxxxxx:b")) }

      it { should be == 18 }
    end
  end
end

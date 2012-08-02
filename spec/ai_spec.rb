require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::AI do
  describe "Evaluation" do
    context "in a situation favorable to black" do
      before do
        @black = Checkers::AI.new("bbbbbbbbbbbbxxxxxxxxxxwwwwwwwwww:b")
        @white = Checkers::AI.new("bbbbbbbbbbbbxxxxxxxxxxwwwwwwwwww:w")
      end

      specify { @white.evaluate.should be < 0 }
      specify { @black.evaluate.should be > 0 }
    end

    context "in a situation favorable to white" do
      before do
        @black = Checkers::AI.new("bbbbbbbbxxxxxwwwwxwwwwwwwwxxxxxx:b")
        @white = Checkers::AI.new("bbbbbbbbxxxxxwwwwxwwwwwwwwxxxxxx:w")
      end

      specify { @white.evaluate.should be > 0 }
      specify { @black.evaluate.should be < 0 }
    end
  end
end

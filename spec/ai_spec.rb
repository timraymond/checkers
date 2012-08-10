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

  describe "Choose" do
    before do
      @ai = Checkers::AI.new(Checkers::Game.new, alpha_beta: true, depth: 1)

      # Add a mechanism to count the number of leaves generated to @ai
      class << @ai
        alias real_evaluation evaluate

        def evaluate(*args)
          @leaf_counter ||= 0
          @leaf_counter = @leaf_counter + 1
          real_evaluation(*args)
        end

        def leaf_count
          @leaf_counter || 0
        end
      end
    end

    it "has 7 leaves from the starting position" do
      @ai.choose
      @ai.leaf_count.should == 7
    end
  end
end

require File.expand_path('../../lib/checkers', __FILE__)

describe Checkers::Jump do
  before do
    @game = Checkers::Game.from_text("bbbbbbbbbbbbxxxwxxxwwwwwwwwwww:b")

    # Setup classes of possible jumps
    @valid_jump   = @game.instance_eval { build_jump(12, 16, 19) }
    @invalid_jump = @game.instance_eval { build_jump(11, 15, 18) }
    @broken_jump  = @game.instance_eval { build_jump( 1,  7, 17) }
  end

  context "where cells form a neighbor chain" do
    context "with a valid jump" do
      subject { @valid_jump }

      it      { should be_valid }
      specify { @valid_jump.execute.should_not be_nil }
    end

    context "with an invalid jump" do
      subject { @invalid_jump }

      it      { should_not be_valid }
      specify { @invalid_jump.execute.should be_nil }
    end
  end

  context "where cells do not form a neighbor chain" do
    subject { @broken_jump }
    it {should_not be_valid }
    specify { @broken_jump.execute.should be_nil }
  end
end

require "spec_helper"

describe Foul do
    before(:each) do
        @match = get_empty_match

        @home_member = @match.members_home.first
        @away_member = @match.members_away.first
    end

    it "should after foul increase member foul count, team foul count by 1" do
        lambda { Foul.new(@home_member, @away_member) }.should increment(:fouls_total).on([@home_member, @match])
    end
end

require "spec_helper"

describe MatchMember do
    before (:each) do
        @match = get_empty_match()
        @home_member = @match.members_home.first
    end
    it "should have 0 points after creation" do
        @home_member.points.should == 0
    end

    it "should have 0 total throws after creation" do
        @home_member.throws_total.should == 0
    end
    
    it "should have 0 accurate throws after creation" do
        @home_member.throws_accurate.should == 0
    end

    it "should have 0 fould after creation" do
        @home_member.fouls_total.should == 0
    end
end

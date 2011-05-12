require "spec_helper"

describe Foul do
    fixtures :people, :teams, :matches, :match_members, :team_members
    before(:each) do
        @match = matches(:match1) 

        @home_member = @match.members_home.first
        @away_member = @match.members_away.first
    end

    it "should after foul increase member foul count, team foul count by 1" do
        lambda { Foul.create(:match_member => @home_member, :against => @away_member) }.should increment(:fouls_total).on([@home_member, @match])
    end
end

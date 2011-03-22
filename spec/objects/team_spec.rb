require "./objects/team"
require "./objects/person"
require "./objects/team_member"

describe Team do
    before (:each) do
        @team = Team.new
    end

    it "should have no members when new team is created" do
        @team.members.should have(0).things
    end

    it "should have 1 team member after adding member" do
        @team.add_member(Person.new)

        @team.members.should have(1).things
        @team.members[0].should be_instance_of(TeamMember)
    end

    it "should have member pointing to current team after adding member" do
        @team.add_member(Person.new)
        @team.members[0].team.should == @team
    end
end

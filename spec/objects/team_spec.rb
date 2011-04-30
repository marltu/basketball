require "./objects/team"
require "./objects/person"
require "./objects/team_member"

describe Team do
    before (:each) do
        @team = Team.new
        @person = Person.new
        @team.save
        @person.save
    end

    it "should have no members when new team is created" do
        @team.team_members.should be_empty
    end

    it "should have 1 team member after adding member" do
        @team.add_member(@person, 13)

        @team.should have(1).team_members
    end

    it "member of team should be TeamMember" do
        @team.add_member(@person, 13)

        @team.team_members.first.should be_instance_of(TeamMember)
    end

    it "should have member pointing to current team after adding" do
        @team.add_member(@person, 13)
        @team.team_members.first.team.should == @team
    end
    
    it "should have member pointing to added person after adding" do
        @team.add_member(@person, 13)
        @team.team_members.first.person.should == @person
    end

    it "should have member with team number 13 after adding such member" do
        @team.add_member(@person, 13)
        @team.team_members.first.number.should == 13
    end

    it "should be able to set team name" do
        @team.name = "Lietuvos Rytas"
        @team.name.should == "Lietuvos Rytas"
    end
end

require "./objects/match"
require "./objects/team"
require "./objects/errors/action_error"


describe Match do
    before(:each) do
        @team_home = Team.new
        @team_home.name = "Home team"

        @team_home.add_member(Person.new("Home", "Player"), 13)

        @team_away = Team.new
        @team_away.name = "Away team"

        @team_away.add_member(Person.new("Away", "Player"), 14)
    end
    
    it "should create match with specified teams" do
        match = Match.new(@team_home, @team_away)
        match.team_home.should == @team_home
        match.team_away.should == @team_away
    end

    it "should create home team player after creating match" do
        match = Match.new(@team_home, @team_away)
        match.should have(1).members_home
    end

    it "should create home team player after creating match" do
        match = Match.new(@team_home, @team_away)
        match.members_home.should include_member_with_number(13)
    end
    it "should create away team player after creating match" do
        match = Match.new(@team_home, @team_away)
        match.members_away.should include_member_with_number(14)
    end

    it "home team should have 0 points before match" do
        match = Match.new(@team_home, @team_away)
        match.points_home.should == 0
    end
    it "away team should have 0 points before match" do
        match = Match.new(@team_home, @team_away)
        match.points_away.should == 0
    end

    it "should raise exception when creating match between the same team" do
        lambda { Match.new(@team_home, @team_home) }.should raise_error ActionError
    end
end

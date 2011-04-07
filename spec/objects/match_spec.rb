require "./objects/match"
require "./objects/team"

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
        match.members_home.first.team_member.number.should == 13
    end
    it "should create away team player after creating match" do
        match = Match.new(@team_home, @team_away)
        match.members_away.first.team_member.number.should == 14
    end

    it "home team should have 0 points before match" do
        match = Match.new(@team_home, @team_away)
        match.points_home.should == 0
    end
    it "away team should have 0 points before match" do
        match = Match.new(@team_home, @team_away)
        match.points_away.should == 0
    end
end

require "spec_helper"
require "mocha"


describe Match do
    before(:each) do
        @team_home = Team.new(:name => "Home Team")
        member = Person.new(:name => "Home", :surname => "Player")
        member.save
        @team_home.add_member(member, 13)

        @team_away = Team.new(:name => "Away Team")
        member = Person.new(:name => "Away", :surname => "Player")
        member.save
        @team_away.add_member(member, 14)
    end
    
    it "should create match with specified teams" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.team_home.should == @team_home
        match.team_away.should == @team_away
    end

    it "should create home team player after creating match" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.should have(1).members_home
    end

    it "should create home team player after creating match" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.members_home.should include_member_with_number(13)
    end
    it "should create away team player after creating match" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.members_away.should include_member_with_number(14)
    end

    it "home team should have 0 points before match" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.points_home.should == 0
    end
    it "away team should have 0 points before match" do
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
        match.points_away.should == 0
    end

    it "should raise exception when creating match between the same team" do
        lambda { Match.create!(:team_home => @team_home, :team_away => @team_home) }.should raise_error ActiveRecord::RecordInvalid
    end

    it "should not be valid with two teams which are the same" do
        Match.new(:team_home => @team_home, :team_away => @team_home).valid?.should == false
    end

    it "should call create_match_members when creating new match" do
        Match.any_instance.expects(:create_match_members)
        match = Match.create(:team_home => @team_home, :team_away => @team_away)
    end
end

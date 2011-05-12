require "spec_helper"

describe Throw do

    before(:each) do
        @match = get_empty_match()
        @home_member = @match.members_home.first
        @away_member = @match.members_away.first
    end

    it "should increase count of throws after creating throw" do
        expect { Throw.new(@home_member, 3) }.to change(Throw, :count).by(1)
    end

    it "should set points to registered throw" do
        Throw.new(@home_member, 3).points.should == 3
    end

    it "should set member to registered throw" do
        Throw.new(@home_member, 3).match_member.should == @home_member
    end

    it "should set accurate flag to registered throw" do
        Throw.new(@home_member, 3, false).accurate = false
    end

    it "should increase home match member points by 3 after registering 3 points" do
        expect { Throw.new(@home_member, 3) }.to change(@home_member, :points).by(3)
    end

    it "should decrease home match member points by 3 after deleting 3 points throw" do
        thr = Throw.new(@home_member, 3)
        expect { thr.delete }.to change(@home_member, :points).by(-3)
    end

    it "should increase away match member points by 3 after registering 3 points" do
        expect { Throw.new(@away_member, 3) }.to change(@away_member, :points).by(3)
    end

    it "should decrease away match member points by 3 after deleting 3 points throw" do
        thr = Throw.new(@away_member, 3)
        expect { thr.delete }.to change(@away_member, :points).by(-3)
    end

    it "should increase match home points by 3 after registering 3 points" do
        expect { Throw.new(@home_member, 3) }.to change(@match, :points_home).by(3)
    end

    it "should decrease match home points by 3 after deleting 3 points throw" do
        thr = Throw.new(@home_member, 3)
        expect { thr.delete }.to change(@match, :points_home).by(-3)
    end


    it "should increase match away points by 3 after registering 3 points" do
        expect { Throw.new(@away_member, 3) }.to change(@match, :points_away).by(3)
    end

    it "should decrease match away points by 3 after deleting 3 points throw" do
        thr = Throw.new(@away_member, 3)
        expect { thr.delete }.to change(@match, :points_away).by(-3)
    end

    
    it "should not increase home match member points when throw is missed" do
        lambda { Throw.new(@home_member, 3, false) }.should_not change(@home_member, :points)
    end

    it "should increase total throws after accurate throw" do
        expect { Throw.new(@home_member, 3, true) }.to change(@home_member, :throws_total).by(1)
    end

    it "should increase total throws after inaccurate throw" do
        expect { Throw.new(@home_member, 3, false) }.to change(@home_member, :throws_total).by(1)
    end


    it "should increase accurate throws after accurate throw" do
        expect { Throw.new(@home_member, 3, true) }.to change(@home_member, :throws_accurate).by(1)
    end

    it "should not increase accurate throws after inaccurate throw" do
        lambda { Throw.new(@home_member, 3, false) }.should_not change(@home_member, :throws_accurate)
    end

    it "should increase number of throws from 2 points by 1" do
        expect { Throw.new(@home_member, 2, true) }.to change {@home_member.throws_total(2)}.by(1)
    end

    it "should not increase number of throws from 2 points after registering 3 point throw" do
        lambda { Throw.new(@home_member, 3, true) }.should_not change {@home_member.throws_total(2)}
    end

    it "should increase number of accurate throws from 2 points after registering 2 point throw" do
        expect { Throw.new(@home_member, 2, true) }.to change {@home_member.throws_accurate(2)}.by(1)
    end


    it "should not increase number of accurate throws from 2 points after registering 3 point throw" do
        lambda { Throw.new(@home_member, 3, true) }.should_not change {@home_member.throws_accurate(2)}
    end

    it "should have 0.33 accuracy after 1 accurate throw and 2 inaccurates" do
        Throw.new(@home_member, 3, true)
        Throw.new(@home_member, 3, false)
        Throw.new(@home_member, 3, false)

        @home_member.accuracy.should == 1/3.0
    end

    it "should have 0.5 accuracy from 2 points after 1 accurate and one inaccurate from 2 points and one accurate 3 point" do
        Throw.new(@home_member, 2, true)
        Throw.new(@home_member, 2, false)
        Throw.new(@home_member, 3, true)

        @home_member.accuracy(2).should == 0.5
    end

    it "should call points on all match_members when asking for match throws" do
        @match.members_home.each do |member|
            member.expects(:points).returns(1)
        end
        
        @match.points_home
    end

    it "should not call points on any match_members when asking for different team points" do

        @match.members_home.each do |member|
            member.expects(:points).never
        end
        
        @match.points_away
    end


    it "should sum every member exactly once (number of points when each player has 1 point should be equal to number of players" do

        @match.members_home.each do |member|
            member.stubs(:points).returns(1)
        end

                
        @match.points_home.should == 1
    end
end

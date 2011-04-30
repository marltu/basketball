require "./objects/match_member"
require "./objects/team"
require "./objects/errors/action_error"
require "active_record"

class Match < ActiveRecord::Base

    has_many :members_home, :class_name => "MatchMember", :conditions => ['team_type = ?', :home]
    has_many :members_away, :class_name => "MatchMember", :conditions => ['team_type = ?', :away]

    belongs_to :team_home, :class_name => "Team"
    belongs_to :team_away, :class_name => "Team"


    def initialize(team_home, team_away)
        if team_home == team_away
            raise ActionError, "Can't create match between the same team"
        end

        super(:team_home => team_home, :team_away => team_away)
        save()

        create_match_members()
    end

    def create_match_members()

        create_team_members(team_home, :home)
        create_team_members(team_away, :away)        
    end

    def create_team_members(team, team_type)
        team.team_members.each do |member|
            MatchMember.create(:team_member => member, :match => self, :team_type => team_type)
        end
    end

    def points_home
        total = 0
        members_home.each { |member| total += member.points}

        return total
    end

    def points_away
        total = 0
        members_away.each { |member| total += member.points}

        return total
    end

    def fouls_total
        total = 0

        members_home.each { |member| total += member.fouls_total }
        members_away.each { |member| total += member.fouls_total }

        return total
    end
end

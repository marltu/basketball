require "./objects/match_member"
require "./objects/team"
require "./objects/errors/action_error"
require "active_record"

class Match < ActiveRecord::Base
    attr_reader :members_home
    attr_reader :members_away

    relation_one :Team, "team_home_id", :team_home
    relation_one :Team, "team_away_id", :team_away


    def initialize(team_home, team_away)
        if team_home == team_away
            raise ActionError, "Can't create match between the same team"
        end

        super()

        @team_home_id = team_home.id
        @team_away_id = team_away.id

        create_match_members()
    end

    def members_home
        MatchMember.find_by(:match => self, :team_type => :home)
    end
    
    def members_away
        MatchMember.find_by(:match => self, :team_type => :away)
    end

    def create_match_members()

        create_team_members(team_home, :home)
        create_team_members(team_away, :away)        
    end

    def create_team_members(team, team_type)
        team.members.each do |member| 
            MatchMember.new(member, self, team_type) 
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

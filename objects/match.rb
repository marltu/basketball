require "./objects/match_member"
require "./objects/team"
require "./lib/active_record"

class Match < ActiveRecord
    attr_reader :members_home
    attr_reader :members_away

    def initialize(team_home, team_away)
        super()

        @team_home_id = team_home.id
        @team_away_id = team_away.id

        create_match_members()
    end

    def team_home
        Team.get(@team_home_id)
    end

    def team_away
        Team.get(@team_away_id)
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
end

require "./objects/team_member"
require "./objects/match"
require "./lib/active_record"

class MatchMember < ActiveRecord

    attr_accessor :team_type
    
    def initialize(team_member, match, team_type)
        super()
        @team_member_id = team_member.id
        @match_id = match.id
        @team_type = team_type
    end

    def match
        Match.get(@match_id)
    end

    def team_member
        TeamMember.get(@team_member_id)
    end
end

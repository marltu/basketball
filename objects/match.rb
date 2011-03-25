require "./objects/match_member"

class Match
    attr_reader :team_home
    attr_reader :team_away

    attr_reader :members_home
    attr_reader :members_away

    def initialize(team_home, team_away)
        @team_home = team_home
        @team_away = team_away

        create_match_members()
    end

    def create_match_members()
        @members_home = create_team_members(@team_home)
        @members_away = create_team_members(@team_away)        
    end

    def create_team_members(team)
        team.members.each.collect { |member| MatchMember.new(member) }
    end



end

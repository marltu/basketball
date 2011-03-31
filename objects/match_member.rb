require "delegate"

require "./objects/team_member"

class MatchMember < DelegateClass(TeamMember)
    def initialize(member, match)
        @member = member
        super(@member)
    end
end

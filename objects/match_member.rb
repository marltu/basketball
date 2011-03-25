require "delegate"

require "./objects/team_member"

class MatchMember < DelegateClass(TeamMember)
    def initialize(member)
        @member = member
        super(@member)
    end
end

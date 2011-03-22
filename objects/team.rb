require "./objects/team_member.rb"

class Team
    @members

    attr_reader :members

    def initialize()
        @members = []
    end

    def add_member(person)
        team_member = TeamMember.new(person, self)
        @members << team_member
    end
end

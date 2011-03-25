require "./objects/team_member.rb"

class Team
    @name
    @members

    attr_reader :members
    attr_accessor :name

    def initialize()
        @members = []
    end

    def add_member(person, number)
        team_member = TeamMember.new(person, self, number)
        @members << team_member
    end
end

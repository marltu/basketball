class TeamMember
    @person
    @team

    attr_reader :person
    attr_reader :team

    def initialize(person, team)
        @person = person
        @team = team
    end
end

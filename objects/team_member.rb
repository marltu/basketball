class TeamMember
    attr_reader :person
    attr_reader :team
    attr_accessor :number

    def initialize(person, team, number)
        @person = person
        @team = team
        @number = number
    end
end

require "./objects/team"

require "./lib/active_record.rb"

class TeamMember < ActiveRecord
    attr_accessor :number

    def initialize(person, team, number)
        @person_id = person.id
        @team_id = team.id
        @number = number

        super()
    end

    def team
        Team.get(@team_id)
    end

    def person
        Person.get(@person_id)
    end
end

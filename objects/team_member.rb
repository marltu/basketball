require "./objects/team"

require "active_record"

class TeamMember < ActiveRecord::Base
    attr_accessor :number
    has_one :team
    has_one :person

    def initialize(person, team, number)
        super()
        @person_id = person.id
        @team_id = team.id
        @number = number

    end
end

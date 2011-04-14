require "./objects/team"

require "activerecord"

class TeamMember < ActiveRecord::Base
    attr_accessor :number
    relation_one :Team, "team_id", :team
    relation_one :Person, "person_id", :person

    def initialize(person, team, number)
        super()
        @person_id = person.id
        @team_id = team.id
        @number = number

    end
end

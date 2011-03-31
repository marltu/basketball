require "./objects/team_member.rb"
require "./lib/active_record.rb"

class Team < ActiveRecord
    @name

    attr_accessor :name

    def members
        TeamMember.find_by(:team => self)
    end

    def add_member(person, number)
        team_member = TeamMember.new(person, self, number)
    end
end

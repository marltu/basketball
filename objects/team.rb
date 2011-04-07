require "./objects/team_member.rb"
require "./lib/active_record.rb"

class Team < ActiveRecord
    attr_accessor :name

    relation_many :TeamMember, "team", :members
    def add_member(person, number)
        team_member = TeamMember.new(person, self, number)
    end
end

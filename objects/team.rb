require "./objects/team_member.rb"
require "active_record"

class Team < ActiveRecord::Base
    attr_accessor :name

    has_many :team_members
    def add_member(person, number)
        team_member = TeamMember.new(person, self, number)
    end
end

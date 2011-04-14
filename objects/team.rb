require "./objects/team_member.rb"
require "activerecord"

class Team < ActiveRecord::Base
    attr_accessor :name

    relation_many :TeamMember, "team", :members
    def add_member(person, number)
        team_member = TeamMember.new(person, self, number)
    end
end

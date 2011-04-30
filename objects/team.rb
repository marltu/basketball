require "./objects/team_member.rb"
require "active_record"

class Team < ActiveRecord::Base
    has_many :team_members
    
    def add_member(person, number)
        TeamMember.create(:person => person, :team => self, :number => number)
        
    end
end

require "./objects/team"

require "active_record"

class TeamMember < ActiveRecord::Base
    belongs_to :team
    belongs_to :person
end

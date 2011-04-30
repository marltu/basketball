require "active_record"
require "./objects/match_member"

class Foul < ActiveRecord::Base

    belongs_to :match_member
    belongs_to :against, :class_name => "MatchMember"

    def initialize(match_member, against)
        super(:match_member => match_member, :against => against)
        save()
    end
end

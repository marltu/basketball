require "active_record"
require "./objects/match_member"

class Foul < ActiveRecord::Base

    has_one :match_member, "match_member_id"
    has_one :against, :class_name => "MatchMember"

    def initialize(match_member, against)
        @match_member_id = match_member.id
        @against_id = against.id

        super()
    end
end

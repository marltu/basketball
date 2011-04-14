require "activerecord"
require "./objects/match_member"

class Foul < ActiveRecord::Base

    relation_one :MatchMember, "match_member_id", :match_member
    relation_one :MatchMember, "against_id", :against

    def initialize(match_member, against)
        @match_member_id = match_member.id
        @against_id = against.id

        super()
    end
end

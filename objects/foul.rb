require "./lib/active_record"
require "./objects/match_member"

class Foul < ActiveRecord

    relation_one :MatchMember, "match_member_id", :match_member
    relation_one :MatchMember, "against_id", :against

    def initialize(match_member, against)
        @match_member_id = match_member.id
        @against_id = against.id

        super()
    end
end

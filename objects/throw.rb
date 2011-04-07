require "./lib/active_record"

class Throw < ActiveRecord
    attr_accessor :points
    attr_accessor :accurate

    relation_one :MatchMember, "match_member_id", :match_member

    def initialize(match_member, points, accurate = true)
        super()

        @match_member_id = match_member.id
        @points = points
        @accurate = accurate
    end
end

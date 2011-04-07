require "./objects/team_member"
require "./objects/match"
require "./objects/throw"
require "./lib/active_record"

class MatchMember < ActiveRecord

    attr_accessor :team_type

    relation_one :Match, "match_id", :match
    relation_one :TeamMember, "team_member_id", :team_member
    relation_many :Throw, "match_member", :throws
    
    def initialize(team_member, match, team_type)
        super()
        @team_member_id = team_member.id
        @match_id = match.id
        @team_type = team_type
    end

    def points
        total = 0
        throws.each do |thr| 
            if thr.accurate
                total += thr.points
            end
        end

        return total
    end

    def throws_total(points = nil)
        if points.nil?
            throws.size
        else
            throws.select { |thr| thr.points == points }.size
        end
    end

    def throws_accurate(points = nil)
        accurate = throws.select { |thr| thr.accurate }
        if points.nil?
            accurate.size
        else
            accurate.select { |thr| thr.points == points }.size
        end
    end

    def accuracy(points = nil)
        throws_accurate(points).fdiv throws_total(points)
    end
end

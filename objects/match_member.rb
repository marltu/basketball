require "./objects/team_member"
require "./objects/match"
require "./objects/throw"
require "./objects/foul"
require "active_record"

class MatchMember < ActiveRecord::Base

    belongs_to :match
    belongs_to :team_member
    
    has_many :throws
    has_many :fouls
    
    def points
        total = 0
        throws(true).each do |thr| 
            if thr.accurate
                total += thr.points
            end
        end

        return total
    end

    def throws_total(points = nil)
        if points.nil?
            throws(true).size
        else
            throws(true).select { |thr| thr.points == points }.size
        end
    end

    def throws_accurate(points = nil)
        accurate = throws(true).select { |thr| thr.accurate }
        if points.nil?
            accurate.size
        else
            accurate.select { |thr| thr.points == points }.size
        end
    end

    def accuracy(points = nil)
        throws_accurate(points).fdiv throws_total(points)
    end

    def fouls_total
        fouls(true).size
    end
end

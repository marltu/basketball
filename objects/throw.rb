require "active_record"

class Throw < ActiveRecord::Base
    belongs_to :match_member

    def initialize(match_member, points, accurate = true)
        super(:match_member => match_member, :points => points, :accurate => accurate)
        save()
    end
end

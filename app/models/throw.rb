class Throw < ActiveRecord::Base
    belongs_to :match_member

    validates_numericality_of :points, :greater_than => 0, :less_than_or_equal_to => 3

    def initialize(match_member, points, accurate = true)
        super(:match_member => match_member, :points => points, :accurate => accurate)
        save()
    end
end

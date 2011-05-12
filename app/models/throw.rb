class Throw < ActiveRecord::Base
    belongs_to :match_member

    validates_numericality_of :points, :greater_than => 0, :less_than_or_equal_to => 3

    after_initialize :default_accuracy

    def default_accuracy
        if (self.accurate.nil?)
            self.accurate = true
        end
    end

end

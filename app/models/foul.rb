class Foul < ActiveRecord::Base

    belongs_to :match_member
    belongs_to :against, :class_name => "MatchMember"

    validates_presence_of :match_member

end

require "active_record"


class Person < ActiveRecord::Base
    attr_accessor :name
    attr_accessor :surname

    def initialize(name = nil, surname = nil)
        super()
        @name = name
        @surname = surname
    end
end

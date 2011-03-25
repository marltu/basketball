class Person
    attr_accessor :name
    attr_accessor :surname

    def initialize(name = nil, surname = nil)
        @name = name
        @surname = surname
    end
end

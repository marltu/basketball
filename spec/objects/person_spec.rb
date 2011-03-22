require './objects/person'

describe Person do
    it "initializes" do
        person = Person.new
    end

    it "should set and get name and surname" do
        person = Person.new
        person.name = "Marius"
        person.surname = "Grigaitis"

        person.name.should == 'Marius'
        person.surname.should == 'Grigaitis'
    end
end

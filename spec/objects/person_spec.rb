require './objects/person'

describe Person do
    it "initializes" do
        person = Person.new
    end

    it "should set name and surname" do
        person = Person.new
        person.name = "Marius"
        person.surname = "Grigaitis"

        person.name.should == 'Marius'
        person.surname.should == 'Grigaitis'
    end

    it "should initialize with name and surname" do
        person = Person.new("Marius", "Grigaitis")

        person.name.should == "Marius"
        person.surname.should == "Grigaitis"
    end
end

require "spec_helper"

describe Person do
    it "initializes" do
        person = Person.new
    end

    it "should set name and surname" do
        person = Person.new(:name => "Marius", :surname => "Grigaitis")
        person.name.should == 'Marius'
        person.surname.should == 'Grigaitis'
    end
end

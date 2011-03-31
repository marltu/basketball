require "./lib/active_record.rb"

class ARTestPersonClass < ActiveRecord
    attr_accessor :name
end

class ARTestUserClass < ActiveRecord
    attr_accessor :username
    attr_accessor :person_id
    relation_one ARTestPersonClass, "person_id", :person
end

class ARTestPersonClass
    relation_many ARTestUserClass, "person", :users
end

describe ActiveRecord do
    it "should have numerical id" do
        @instance = ARTestPersonClass.new 
        @instance.id.should be_instance_of Fixnum 
    end

    it "should not have the same id when having two instances" do
        ARTestPersonClass.new.id.should_not == ARTestPersonClass.new.id
    end

    it "should have different increment for different classes" do
        lambda { ARTestUserClass.new }.should_not change(ARTestPersonClass, :increment)
    end

    it "should be able to get the same intance by id" do
        @instance = ARTestPersonClass.new
        ARTestPersonClass.get(@instance.id).should == @instance
    end

    it "should increase count when new instance is created" do
        expect { ARTestPersonClass.new }.to change(ARTestPersonClass, :count).by(1)
    end

    it "should decrease count when instance is deleted" do
        instance = ARTestPersonClass.new

        expect { instance.delete }.to change(ARTestPersonClass, :count).by(-1)
    end

    it "should find instance by attribute" do
        instance = ARTestPersonClass.new
        instance.name = "Petras"

        result = ARTestPersonClass.find_by(:name => "Petras")
        result.should include instance
    end
    
 
    it "should not find instance by attribute using not existing value" do
        instance = ARTestPersonClass.new
        instance.name = "Petriukas"

        result = ARTestPersonClass.find_by(:name => "PetrasSkaicius")
        result.should be_empty
    end

    it "should walk through one relation" do
        instance = ARTestUserClass.new
        
        person = ARTestPersonClass.new
        instance.person_id = person.id
        
        instance.person.should == person 
    end
    it "should walk through many relation" do
        person = ARTestPersonClass.new

        user = ARTestUserClass.new
        user.person_id = person.id

        person.users.should include user
    end
end

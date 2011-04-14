require "./lib/active_record.rb"

class ARTestPersonClass < ActiveRecord
    attr_accessor :name
    relation_many :ARTestUserClass, "person", :users
end

class ARTestUserClass < ActiveRecord
    attr_accessor :username
    attr_accessor :person_id
    relation_one :ARTestPersonClass, "person_id", :person
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

    it "should save model data to .dump file" do
        filename = "db/ARTestPersonClass.dump"
        if File.exists? filename
            File.delete(filename)
        end

        ARTestPersonClass.dump

        correct = nil

        File.open(filename+'-correct') do |f|
            correct = f.read
        end

        File.open(filename) do |f|
            correct.should == f.read
        end
    end

    it "should load model data from .dump file" do
        filename = "db/ARTestPersonClass.dump"
        ARTestPersonClass.dump

        original_instances = ARTestPersonClass.instances
        
        ARTestPersonClass.reset 
        ARTestPersonClass.load

        original_instances.should == ARTestPersonClass.instances

    end

    it "should remove all instances when performing reset" do
        ARTestPersonClass.new
        ARTestPersonClass.reset
        ARTestPersonClass.instances.size.should == 0
    end

    it "should not be equal when comparing different objects" do
        ARTestPersonClass.new.should_not == ARTestPersonClass.new
    end

    it "should be equal when comparing the same object" do
        o = ARTestPersonClass.new
        o.should == o
    end

end

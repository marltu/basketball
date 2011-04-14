require "./objects/foul"

RSpec::Matchers.define :increment do |method|
    match do |action|
        before = @objects.each.collect do |o|
            o.send(method)    
        end

        action.call()

        @no_errors = true

        @error_object = nil

        @objects.each_with_index do |o, index|
            ok = (o.send(method) == before[index] + 1)
            if (!ok)
                @error_object = o
            end
            @no_errors = @no_errors and ok
        end

        @no_errors
    end

    failure_message_for_should do
        "#{@error_object} #{method} should have increased"
    end

    chain :on do |objects|
        @objects = objects
    end
end

describe Foul do
    before(:each) do
        @match = get_empty_match

        @home_member = @match.members_home.first
        @away_member = @match.members_away.first
    end

    it "should after foul increase member foul count, team foul count by 1" do
        lambda { Foul.new(@home_member, @away_member) }.should increment(:fouls_total).on([@home_member, @match])
    end
end

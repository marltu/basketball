require 'simplecov'

SimpleCov.start do
    add_filter 'spec'
end


require "./objects/team"
require "./objects/person"
require "./objects/match"

def get_empty_match
    team_home = Team.new
    team_home.name = "Home team"

    team_home.add_member(Person.new("Home", "Player"), 13)

    team_away = Team.new
    team_away.name = "Away team"

    team_away.add_member(Person.new("Away", "Player"), 14)

    return Match.new(team_home, team_away)
end

RSpec::Matchers.define(:be_same_file_as) do |exected_file_path|
  match do |actual_file_path|
    md5_hash(actual_file_path).should == md5_hash(exected_file_path)
  end
  
  def md5_hash(file_path)
    Digest::MD5.hexdigest(File.read(file_path))    
  end
end


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

RSpec::Matchers.define :include_member_with_number do |number|
    match do |members|
        @includes = false
        members.each do |member|
            if member.team_member.number == number
                @includes = true
            end
        end
        @includes
    end
end

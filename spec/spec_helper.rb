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

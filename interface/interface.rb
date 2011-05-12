require "./config/environment"

class Interface
    def run
        load_data
        print_teams
        select_team

        while (!@match_ended) do
            print_match
            match_command_input
        end
    end

    def load_data

    end

    def print_teams
        teams = Team.find :all
        teams.each do |team| 
            print "#{team.id}: #{team.name} \n"    
        end
    end

    def select_team
        home_team = nil
        away_team = nil
        while (home_team.nil?) do
            print "Select home team: "
            home_team = Team.find_by_id(integer_input)
            print "Invalid team \n" if home_team.nil?
        end

        while (away_team.nil?) do
            print "Select away team: "
            away_team = Team.find_by_id(integer_input)
            print "Invalid team \n" if away_team.nil?
        end

        @match = Match.create(:team_home => home_team, :team_away => away_team)
    end

    def print_match
        print "MATCH: #{@match.team_home.name} - #{@match.team_away.name} "
        print "#{@match.points_home}:#{@match.points_away}\n"
        print "\n"


        print "#{@match.team_home.name} players:\n"
        print_players(@match.members_home)
        print "\n"

        print "#{@match.team_away.name} players:\n"
        print_players(@match.members_away)
        print "\n"

    end

    def print_players(members)
        members.each do |member|
            print "#{member.team_member.number}. #{member.team_member.person.name} #{member.team_member.person.surname} "
            print "T: #{member.throws_accurate}/#{member.throws_total} "

            if (not member.accuracy.nan?)
                print "(#{"%.2f" % member.accuracy}) "
            end

            print "F: #{member.fouls_total}"
            print "\n"
        end
    end

    def match_command_input
       print "Command: "
       
       match_execute(string_input)

       print "\n"
    end

    def integer_input
        gets.to_i
    end

    def string_input
        gets.chomp
    end

    def match_execute(command)
        args = command.split(" ")
        case args[0]
            when "throw1" then register_throw(1, args)
            when "throw" then register_throw(2, args)
            when "throw3" then register_throw(3, args)

            when "ithrow1" then register_throw(1, args, false)
            when "ithrow" then register_throw(2, args, false)
            when "ithrow3" then register_throw(3, args, false)
            
            when "foul" then register_foul(args)

            when "q" then @match_ended = true
            else help()
        end  
    end

    def register_foul(args)
        if (args.size < 3)
            print "Invalid number of arguments\n"
            gets
            return
        end

        member = parse_member(args[1])
        against = parse_member(args[2])

        if (member.nil? or against.nil?)
            puts "Invalid members\n"
            gets
            return nil
        else
            Foul.create(:match_member => member, :against => against)
            print "Foul registered\n"
        end

    end

    def register_throw(points, args, accurate = true) 
        if (args.size < 2) 
            print "Invalid number of arguments\n"
            gets
            return
        end

        member = parse_member(args[1])
        if (!member.nil?)
            print "Throw registered \n"
            Throw.create(:match_member => member, :points => points, :accurate => accurate)
        end
    end

    def parse_member(code)
        invalid_member = false
        number_only = code.reverse.chop.reverse.to_i
        member = nil

        if code.start_with? "h"
            member = find_member_by_number(@match.members_home, number_only)
        elsif code.start_with? "a"
            member = find_member_by_number(@match.members_away, number_only)
        else
            invalid_member = true
        end

        if invalid_member or member.nil?
            puts "Invalid member \n"
            gets
            return nil
        else
            return member
        end
    end
    
    def find_member_by_number(members, number)
        members.each do |member|
            if member.team_member.number == number
                return member
            end
        end
        return nil
    end

    def help
        print "HELP"
        print "\n"
        gets
    end


end

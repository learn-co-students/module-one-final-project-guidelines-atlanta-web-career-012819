class CLI

  def self.run
    CLI.greet

    while true
      print "\nEnter command: ".cyan
      input = gets.chomp

      break if input == "quit" || input == "exit"

      case input
      when "help"
        CLI.help
      when "list shows"
        CLI.list_shows
      when "list viewers"
        CLI.list_viewers
      when "list countries"
        CLI.list_countries
      when "show"
        CLI.show
      when "viewer"
        CLI.viewer
      when "self help"
        puts "Thank you for taking the time to reflect, and recognizing the importance of self care. <3"
        puts "\n"
        heart_string = ""
        10.times { heart_string += "<3" }
        10.times do
          puts heart_string.red
        end
      else
        puts "invalid command, type 'help' to see a list of available commands"
      end
    end
  end

  def self.greet
    puts "Welcome to the TV Show Database, powered by TVMAZE".magenta
    puts "Type 'help' to see the list of available commands. Type 'quit' to exit.".magenta
  end

  def self.help
    puts "Help".bold
    puts "  help\t\t\t:show this help menu".green
    puts "List".bold
    puts "  list shows\t\t:list all show titles".green
    puts "  list viewers\t\t:list names of all viewers".green
    puts "  list countries\t:list names of all countries between shows/viewers".green
    puts "Data".bold
    puts "  show\t\t\t:go to menu for show data".green
    puts "  viewer\t\t:go to menu for viewer data".green
    puts "Quit".bold
    puts "  quit\t\t\t:quit the program".green
    puts "  exit\t\t\t:alias for quit".green
  end

  def self.list_shows
    Show.all.each_with_index { |show,i| puts (i+1).to_s.bold + ".\t#{show.title}" }
  end

  def self.list_viewers
    Viewer.all.each_with_index { |viewer,i| puts (i+1).to_s.bold + ".\t#{viewer.name}" }
  end

  def self.list_countries
    Show.countries.each { |country| puts country }
  end

  def self.show_data(show)
    puts "  title:\t\t#{show.title}"
    puts "  network:\t\t#{show.network}"
    puts "  country:\t\t#{show.country}"
    puts "  total viewers:\t#{show.num_ratings}"
    puts "  average rating:\t#{show.average_rating}"
  end

  def self.show
    loop do
      puts "\nType 'list' to list all shows, or 'exit' to return to main menu".magenta
      print "Enter show ID: ".cyan

      input = gets.chomp

      break if input == "exit" || input == "quit"

      if input == "list"
        CLI.list_shows
      else
        begin
          id = input.to_i

          ## TODO: This will also handle cases where input is not an integer
          ## WHY?
          raise CLIError if id > Show.count || id < 1
          show = Show.all[id-1]
          CLI.show_data(show)
          puts "\n"
          loop do
            print "List viewers for this show? (y/n): ".magenta
            yn = gets.chomp

            case yn
            when 'y'
              loop do
                print "List all viewers, in same country, or living elsewhere? (all/same/other): ".magenta

                which_viewers = gets.chomp

                case which_viewers
                when "same"
                  show.viewers.select { |v| v.country == show.country }.each { |v| puts v.name }
                  break
                when "other"
                  # binding.pry
                  show.viewers.reject { |v| v.country == show.country }.each { |v| puts v.name + ",  " + v.country.yellow }
                  break
                when "all"
                  show.viewers.each { |v| puts v.name + ",  " + v.country.yellow }
                  break
                end
              end
              puts "\n"
              # break
            when 'n'
              break
            end
          end
        ## Do some error handling
        rescue CLIError => error
          puts error.message.red
        end
      end
    end
  end

  def self.viewer
    loop do
      puts "\nType 'list' to list all viewers, or 'exit' to return to main menu".magenta
      print "Enter viewer ID: ".cyan

      input = gets.chomp

      break if input == "exit" || input == "quit"

      if input == "list"
        CLI.list_viewers
      else
        begin
          id = input.to_i
          ## FIXME: This is hacky but works
          raise CLIError if id > Viewer.count || id < 1
          viewer = Viewer.all[id-1]
          puts "  name:\t\t#{viewer.name}"
          puts "  country:\t#{viewer.country}"
          puts "  top shows:"
          if viewer.top_three.empty?
            puts "\tno shows rated".upcase.magenta
          else
            puts "\trating\tshow".upcase.magenta
            viewer.top_three.each { |r| puts "\t#{r.rating}\t#{r.show.title}" }
          end
          puts "\n"
          loop do
            print "List data for favorite shows? (y/n): ".magenta
            yn = gets.chomp

            case yn
            when 'y'
              loop do
                print "Which show? (1,2,3): ".magenta
                show_num = gets.chomp.to_i

                if show_num <=3 && show_num > 0
                  CLI.show_data(viewer.top_three[show_num-1].show)
                  puts "\n"
                  break
                end
              end
            when 'n'
              break
            end
          end
        ## Error handling
        rescue CLIError => error
          puts error.message.red
        end
      end
    end
  end

  class CLIError < StandardError
    def message
      "\n  ERROR: invalid operation."
    end
  end
end

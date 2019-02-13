class CLI

  def self.run
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
      else
        puts "invalid command"
      end
    end
  end

  def self.help
    puts "Help".bold
    puts "  help\t\t\t:show this help menu".green
    puts "List".bold
    puts "  list shows\t\t:list all show titles".green
    puts "  list viewers\t\t:list names of all viewers".green
    puts "  list countries\t:list names of all countries between shows/viewers".green
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
          puts "  title:\t#{show.title}"
          puts "  network:\t#{show.network}"
          puts "  country:\t#{show.country}"
        ## Do some error handling
        rescue CLIError => error
          puts error.message.red
        end
      end
    end
  end

  def self.viewer
    print "Enter viewer ID: ".cyan
    id = gets.chomp.to_i

    begin
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
    ## Error handling
    rescue CLIError => error
      puts error.message.red
    end
  end

  class CLIError < StandardError
    def message
      "\n  ERROR: invalid operation."
    end
  end
end

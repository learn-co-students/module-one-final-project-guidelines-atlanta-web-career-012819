class CLI
  def self.run
    while true
      print "\nEnter command: ".cyan
      input = gets.chomp

      break if input == "quit" || input == "exit"

      case input
      when "help"
        puts "Help".bold
        puts "  help\t\t:show this help menu".green
        puts "List".bold
        puts "  list shows\t:list all show titles".green
        puts "  list viewers\t:list names of all viewers".green
        puts "  list countries\t:list names of all countries between shows/viewers".green
        puts "Quit".bold
        puts "  quit\t\t:quit the program".green
        puts "  exit\t\t:alias for quit".green
      when "list shows"
        Show.all.each_with_index { |show,i| puts (i+1).to_s.bold + ".\t#{show.title}" }
      when "list viewers"
        Viewer.all.each_with_index { |viewer,i| puts (i+1).to_s.bold + ".\t#{viewer.name}" }
      when "list countries"
        Show.countries.each { |country| puts country }
      when "show"
        print "Enter show ID: ".cyan
        show = Show.all[gets.chomp.to_i-1]
        puts "  title:\t#{show.title}"
        puts "  network:\t#{show.network}"
        puts "  country:\t#{show.country}"
      when "viewer"
        print "Enter viewer ID: ".cyan
        viewer = Viewer.all[gets.chomp.to_i-1]
        puts "  name:\t\t#{viewer.name}"
        puts "  country:\t#{viewer.country}"
        puts "  top shows:"
        viewer.top_three.each { |s| puts "\t#{s.title}" }
      else
        puts "invalid command"
      end
    end
  end
end

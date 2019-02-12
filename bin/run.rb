require_relative '../config/environment'

puts "Welcome to the TV Show Database, powered by TVMAZE".magenta
puts "Type 'help' to see the list of available commands. Type 'quit' to exit.".magenta

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
    puts "Quit".bold
    puts "  quit\t\t:quit the program".green
    puts "  exit\t\t:alias for quit".green
  when "list shows"
    Show.all.each_with_index { |show,i| puts (i+1).to_s.bold + ".\t#{show.title}" }
  when "list viewers"
    Viewer.all.each_with_index { |viewer,i| puts (i+1).to_s.bold + ".\t#{viewer.name}" }
  when "show countries"
    Show.countries.each { |country| puts country }
  else
    puts "invalid command"
  end
end

require "colorize"
class CommandLineInterface


  def greeting
    puts "-------------------------------------------------------------------".colorize(:light_blue)
    puts "Welcome to Cause Connect, helping donors and organizations connect!".colorize(:yellow)
    puts "-------------------------------------------------------------------".colorize(:light_blue)
    puts "                      What is your name?                           ".colorize(:red)
    name = gets.chomp
    puts "      Hi #{name}. Please choose one of the following options:      ".colorize(:yellow)
  end


  def user_inputs
    puts "                  1. View all organizations"
    puts "                  2. Search for an organization"
    puts "                  3. Add a new organization"
    puts "                  4. Make a donation"
    puts "                  5. Update organization status"
    puts "                  6. Cancel a donation"
    puts "                  7. Exit the program"
    user_input = gets.chomp

    case user_input
    when "1"
      puts Cause.all.map {|cause| cause.name}
    when "2"
      puts "Please enter organization name"
      # user_input = name
      name = gets.chomp

      org = find_by_name(name)
      puts "Category: #{org[:category]}"
      # puts "Category:" + org[:category]
      puts "Organization: #{org[:name]}"
      # puts "Organization:" + org[:name]
      # puts "Status:" + org[:status]
      puts "Status: #{org[:status]}"
    when "3"
      puts "What is the organization name?"
      name = gets.chomp
      puts "What genre?"
      category = gets.chomp
      puts "What is the status of reaching your goal from 1 to 10?"
      status = gets.chomp
      Cause.create(name: name, category: category, status: status)
    when "4"
      puts "What amount would you like to donate?"
      amount = gets.chomp
      puts "Please enter your donor id."
      donor_id = gets.chomp
      puts "Please enter the organization id."
      cause_id = gets.chomp
      Donation.create(amount: amount, donor_id: donor_id, cause_id: cause_id)
    when "5"
      puts "What organizaion would you like to update?"
      name = gets.chomp
      puts "What is the new status of #{name}}?"
      status = gets.chomp
      org = Cause.find_by(name: name)
      org.status = status
      org.save
    when "6"
      puts "Oh no! We are sad to hear you would like to cancel a donation. Please enter your Donor ID."
      donor_id = gets.chomp
      puts "Please enter the Organization Id."
      cause_id = gets.chomp
      cancel(donor_id, cause_id)
    when "7"
      puts "Thanks for your interest, enjoy!".colorize(:light_blue)
    else
      puts "Have a great day!".colorize(:yellow)
    end

  end


  def list_all_by_name(arg)
    arg.all.map {|cause| cause.name}
  end

  def get_org_id(name)
    org = Cause.find_by(name: name)
    org.id
  end

  def find_by_name(name)
    Cause.find_by(name: name)
  end

  def create_org(new_data)
    Cause.create(name: name, category: category, status: status)
  end

  def new_donation(amount, donor_id, cause_id)
    Donation.create(amount: amount, donor_id: donor_id, cause_id: cause_id)
  end

  def update_status(org_name, status)
    org = Cause.find_by(name: org_name)
    org.status = status
    org.save
  end

  def cancel(donor_id, cause_id)
    chosen_1 = Donation.find_by(donor_id: donor_id, cause_id: cause_id)
    chosen_1.destroy
    # puts "Which donation would you like to cancel? Please enter donation id:"
    # no_more
    # user_input = gets.chomp
    # if user_input ==
    # found_org = no_more.select {|name| name.name == org_name}
    # found_org.delete
  end
end

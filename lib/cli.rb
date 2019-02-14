require "colorize"
class CommandLineInterface


  def greeting
    puts "-------------------------------------------------------------------".colorize(:light_blue)
    puts "Welcome to Cause Connect, helping donors and organizations connect!".colorize(:yellow)
    puts "-------------------------------------------------------------------".colorize(:light_blue)
    puts "                      What is your name?                           ".colorize(:red)
    name = gets.chomp
    puts "                        Welcome #{name}!      ".colorize(:yellow)
  end


  def user_inputs
      loop do
      puts "If you would like to see the option menu please type Yes or No)".colorize(:yellow)
      user_input = gets.chomp
      if
        user_input == "No"
        break
      else 
      puts "                  1. View all organizations".colorize(:light_blue)
      puts "                  2. Search for an organization".colorize(:light_blue)
      puts "                  3. Add a new organization".colorize(:light_blue)
      puts "                  4. Make a donation".colorize(:light_blue)
      puts "                  5. Update organization status".colorize(:light_blue)
      puts "                  6. Cancel a donation".colorize(:light_blue)
      user_input = gets.chomp

        case user_input
        when "1"
          puts list_all_by_name(Cause)
          puts "Is that all for today?".colorize(:yellow)
        when "2"
          puts "Please enter organization name".colorize(:yellow)
          # user_input = name
          name = gets.chomp

          org = find_by_name(name)
          puts "Category: #{org[:category]}"
          # puts "Category:" + org[:category]
          puts "Organization: #{org[:name]}"
          # puts "Organization:" + org[:name]
          # puts "Status:" + org[:status]
          puts "Status: #{org[:status]}"
          puts "Is that all for today?".colorize(:yellow)
        when "3"
          puts "What is the organization name?"
          name = gets.chomp
          puts "What genre?"
          category = gets.chomp
          puts "What is the status of reaching your goal from 1 to 10?"
          status = gets.chomp
          Cause.create(name: name, category: category, status: status)
          puts "Your organization has been successfully created.
                Is that all for today?".colorize(:yellow)
        when "4"
          puts "What amount would you like to donate?"
          amount = gets.chomp
          puts "Please enter your donor id."
          donor_id = gets.chomp
          puts "Please enter the organization id."
          cause_id = gets.chomp
          Donation.create(amount: amount, donor_id: donor_id, cause_id: cause_id)
          puts "Your donation has been successfully added.
                Is that all for today?".colorize(:yellow)
        when "5"
          puts "What organizaion would you like to update?"
          name = gets.chomp
          puts "What is the new status of #{name}}?"
          status = gets.chomp
          update_status(name, status)
          puts "Your organization has been successfully updated.
                Is that all for today?".colorize(:yellow)
        when "6"
          puts "          Oh no! We are sad to hear you would like to cancel a donation.
                              Please enter your Donor ID.".colorize(:light_red)
          donor_id = gets.chomp
          puts "Please enter the Organization Id."
          cause_id = gets.chomp
          cancel(donor_id, cause_id)
          puts "Your donation has been canceled.
                Is that all for today?".colorize(:yellow)
        else
          puts "Have a great day!"
          break
        end
    end
  end
end




#   def intro
#     loop do
#     puts "If you would like to see the option menu please type Yes or No)".colorize(:yellow)
#     user_input = gets.chomp
#       if
#         user_input =="No"
#         break
#       else
#         user_input == "Yes"
#     puts "                  1. View all organizations".colorize(:light_blue)
#     puts "                  2. Search for an organization".colorize(:light_blue)
#     puts "                  3. Add a new organization".colorize(:light_blue)
#     puts "                  4. Make a donation".colorize(:light_blue)
#     puts "                  5. Update organization status".colorize(:light_blue)
#     puts "                  6. Cancel a donation".colorize(:light_blue)
#     puts "                  7. Exit the program".colorize(:light_blue)
#     user_input = gets.chomp
#   end
# end


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

  def update_status(name, status)
    org = Cause.find_by(name: name)
    org.status = status
    org.save
  end

  def cancel(donor_id, cause_id)
    chosen_1 = Donation.find_by(donor_id: donor_id, cause_id: cause_id)
    chosen_1.destroy
  end
end

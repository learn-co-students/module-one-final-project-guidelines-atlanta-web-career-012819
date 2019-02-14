require_relative '../config/environment'
require 'colorize'
require 'pry'

cli = CommandLineInterface.new
cli.greeting
cli.user_inputs

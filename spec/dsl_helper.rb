require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'dsl/home_helper'

module Dsl
  $home = HomeDriver.new
end
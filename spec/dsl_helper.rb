require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

require 'dsl/home_helper'

module Dsl
  @homeDriver = HomeDriver.new
  def Dsl.home
    @homeDriver
  end
end

module DslUtil
  def DslUtil.params(supplied, options = {})
    supplied ||= {}
    result = {}
    options.each {|k,v| result[k] = supplied[k] || v}
    result
  end
end
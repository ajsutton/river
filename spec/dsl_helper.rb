# -*- encoding : utf-8 -*-
require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'securerandom'

require 'dsl/home_driver'
require 'dsl/setup_driver'
require 'dsl/people_driver'

module DslUtil
  def DslUtil.params(supplied, options = {})
    supplied ||= {}
    result = {}
    options.each {|k,v| result[k] = supplied[k] || v}
    result
  end
  
  class AliasedObjectStore
    def initialize
      @objects = {}
    end
    
    def get_or_create(key, &block)
      @objects[key] ||= yield(SecureRandom.hex(8))
    end
    
    def get(key)
      @objects[key]
    end
  end
end


module Dsl
  users = DslUtil::AliasedObjectStore.new
  churches = DslUtil::AliasedObjectStore.new
  people = DslUtil::AliasedObjectStore.new
  
  @homeDriver = DslUtil::HomeDriver.new(users)
  @setupDriver = DslUtil::SetupDriver.new(churches)
  @peopleDriver = DslUtil::PeopleDriver.new(people)
  
  def Dsl.home
    @homeDriver
  end
  
  def Dsl.setup
    @setupDriver
  end
  
  def Dsl.people
    @peopleDriver
  end
end


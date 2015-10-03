# -*- encoding : utf-8 -*-
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
require 'require_all'
require_all 'spec/dsl'

module Dsl
  def home
    @homeDriver ||= DslUtil::HomeDriver.new(DslUtil::AliasedObjectStore.new)
  end

  def setup
    @setupDriver ||= DslUtil::SetupDriver.new(DslUtil::AliasedObjectStore.new, home)
  end

  def people
    @peopleDriver ||= DslUtil::PeopleDriver.new(DslUtil::AliasedObjectStore.new)
  end

  def admin
    @adminDriver ||= DslUtil::AdminDriver.new
  end
end

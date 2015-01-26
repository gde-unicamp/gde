require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
include ::Rails.application.routes.url_helpers
include Capybara::DSL

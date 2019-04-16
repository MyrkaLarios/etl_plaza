# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require_relative "support/simplecov"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "webmock/minitest"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"


class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

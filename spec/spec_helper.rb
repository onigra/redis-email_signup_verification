require 'bundler/setup'
require 'coveralls'
Coveralls.wear!
Bundler.setup

require 'redis/email_signup_verification'
require 'ffaker'
require 'ap'

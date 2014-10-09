require 'redis'
require 'bcrypt'

dir = File.expand_path("email_signup_verification", File.dirname(__FILE__))
require dir + "/version"
require dir + "/redis_ext"

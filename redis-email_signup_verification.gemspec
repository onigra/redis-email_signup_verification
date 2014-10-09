# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis/email_signup_verification/version'

Gem::Specification.new do |spec|
  spec.name          = "redis-email_signup_verification"
  spec.version       = Redis::EmailSignupVerification::VERSION
  spec.authors       = ["onigra"]
  spec.email         = ["3280467rec@gmail.com"]
  spec.summary       = %q{Email SignUp Verification By Redis}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/onigra/redis-email_signup_verification"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end

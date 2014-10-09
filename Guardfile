guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }

  watch(%r{^lib/redis/email_signup_verification/redis_ext.rb$}) { |m| "spec/lib/redis/email_signup_verification/redis_ext_spec.rb" }
end


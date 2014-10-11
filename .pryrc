if Dir["bin/rails", "script/rails"].first #is_rails_app?
  require './config/environment'
  require 'rails/console/app'
  require 'rails/console/helpers'
  extend Rails::ConsoleMethods
elsif Dir["*.gemspec"].first #is_gem?
  Bundler.require if defined? Bundler
  Dir["./lib/*.rb"].each {|file| require file }
end

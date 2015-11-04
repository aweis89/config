if Dir['bin/rails', 'script/rails'].first # for rails apps
  require './config/environment'
  require 'rails/console/app'
  require 'rails/console/helpers'
  extend Rails::ConsoleMethods
elsif Dir['*.gemspec'].first || Dir['Gemfile'] #for gems or sintra like apps
  Bundler.require if defined? Bundler
  Dir['./lib/*.rb'].each {|file| require file }
end

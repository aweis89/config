EXECUTABLES = ['bin/rails', 'script/rails']

if EXECUTABLES.find { |exe| File.file?(exe) }
  require './config/environment'
  require 'rails/console/app'
  require 'rails/console/helpers'
  extend Rails::ConsoleMethods
end

require 'active_record'
require 'sqlite3'
require 'logger'

ROOT = File.join(File.dirname(__FILE__), "..")

['/lib', '/db'].each do |folder|
   $:.unshift File.join(ROOT, folder)
end
 
ActiveRecord::Base.logger = Logger.new('log/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection('development')

require "./db/schema"

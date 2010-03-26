# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/rails/rspec'
require 'webrat/core/matchers'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

# Comment out the next line if you don't want transactions to
# open/roll back around each scenario
#Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
#Cucumber::Rails.bypass_rescue

require 'webrat'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)

Webrat.configure do |config|
 config.mode = :rails
end


Before do
 Fixtures.reset_cache
 fixtures_folder = File.join(RAILS_ROOT, 'spec', 'fixtures')
 fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
 Fixtures.create_fixtures(fixtures_folder, fixtures)
end


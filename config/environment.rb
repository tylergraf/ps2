# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Auth::Application.initialize!

if ENV['RAILS_ENV'] == 'production'  # don't bother on dev
  ENV['GEM_PATH'] = '/home/tylergraf/.gems' + ':/usr/lib/ruby/gems/1.8'  # Need this or Passenger fails to start
  require '/home/tylergraf/.gems/gems/RedCloth-4.1.9/lib/redcloth.rb'  # Need this for EACH LOCAL gem you want to use, otherwise it uses the ones in /usr/lib
end
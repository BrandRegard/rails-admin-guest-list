$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_guest_list/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_guest_list"
  s.version     = RailsAdminGuestList::VERSION
  s.authors     = ["Birgir Hrafn Sigurðsson"]
  s.email       = ["birgir@transmit.is"]
  s.homepage    = "http://www.transmit.is"
  s.summary     = "RailsAdmin gem to display guestlists"
  s.description = "RailsAdmin gem to display guestlist"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"
end

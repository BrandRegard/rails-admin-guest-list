require "rails_admin_guest_list/engine"

module RailsAdminGuestList
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class GuestList < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :object_level do
          true
        end
      end
    end
  end
end


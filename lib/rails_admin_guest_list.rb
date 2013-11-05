require "rails_admin_guest_list/engine"
require 'rails_admin/config/sections/base'

module RailsAdminGuestList
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class GuestList < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          authorized? #&& !bindings[:object].approved
        end

        register_instance_option :root? do
          true
        end

        register_instance_option :link_icon do
#          'icon-book'
          'icon-list-alt'
        end

        register_instance_option :i18n_key do
          'guest_list'
        end

        register_instance_option :controller do 
          Proc.new do
            respond_to do |format|
              format.html {render @action.template_name}
              format.js {render @action.template_name, :layout => false}
            end
          end
        end

      end
    end
  end
end


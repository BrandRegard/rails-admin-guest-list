require "rails_admin_guest_list/engine"
require 'rails_admin/config/sections/base'

module RailsAdminGuestList
end

module RailsAdminCreateBooking
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class CreateBooking < Base
        RailsAdmin::Config::Actions.register(self)

        # Should the action be visible
        register_instance_option :visible? do
          false
        end

        register_instance_option :root? do
          true
        end

        register_instance_option :controller do 
          Proc.new do
            respond_to do |format|
              format.html do 
                flash[:notice] = "Incorrect Booking Method"
                redirect_to "/super/"
              end
              format.json {
                create_booking_form = CreateBookingForm.new(params[:booking])
                if create_booking_form.submit
                  render :json => {:success => true , :results => create_booking_form,:user=>User.find(create_booking_form.user_id),:transaction_date => Time.now.strftime("%Y-%m-%d %H:%M:%S") }
                else
                  render :json => {:success => false , :errors => create_booking_form.errors}
                end
              }
            end
          end
        end
      end
      class GuestList < Base
        RailsAdmin::Config::Actions.register(self)

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


require "rails_admin_guest_list/engine"
require 'rails_admin/config/sections/base'

module RailsAdminGuestList
end

module RailsAdminCreateBooking
end

module RailsAdminUpdateBooking
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions

      class UpdateBooking < Base
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
                redirect_to request.referer
              end
              format.json {
                begin
                  id = params[:booking][:id]
                  ticket_count = params[:booking][:ticket_count].to_i
                  booking = Booking.find(id)
                  new_ticket_count = booking.alter_ticket_count(ticket_count)
                  total_sold = booking.event.bookings.map(&:tickets).flatten.count 
                  sold_out = (total_sold == booking.event.place) 
                  render :json => {:success => true  , :booking_id=> id, :total_sold_tickets=>total_sold ,:sold_out=>sold_out, :ticket_count => new_ticket_count}
                rescue Exception => e
                  render :json => {:success => false , :booking_id=> id, :errors => e.message}
                end
              }
            end
          end
        end
      end

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


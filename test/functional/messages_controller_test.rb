require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  context "MessageController" do
    context "on GET to #index" do
      setup do
        get :index, :ticket_id => Ticket.first.to_param
      end
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should_assign_to :messages
      should_assign_to :ticket
      should_render_with_layout "tickets"
    end

    context "on correct POST to #create" do
      setup do
       post :create, :ticket_id => tickets(:zwrot_tomka).to_param, :message => { :content => "Hi bob",
                                                                                 :from => "shop" }
      end
      should_create :message
      should_redirect_to("created message") { ticket_url(tickets(:zwrot_tomka)) }
      should_set_the_flash_to /created/ 
    end

  end  
end

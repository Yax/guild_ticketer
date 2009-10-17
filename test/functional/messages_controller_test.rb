require 'test_helper'

class Admin::MessagesControllerTest < ActionController::TestCase
  context "MessageController" do

    context "on POST to #create" do
      setup do
       post :create, :ticket_id => tickets(:zwrot_tomka).to_param, :message => { :content => "Hi bob",
                                                                                 :from => "shop" }
      end
      should_create :message
      should_redirect_to("created message") { admin_ticket_url(tickets(:zwrot_tomka)) }
      should_set_the_flash_to /zapisan/ 
    end
    
    context "on GET to #new" do
      setup do
        get :new, :ticket_id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :ticket, :message
    end
    
    context "on GET to #edit" do
      setup do
        get :edit, :id => messages(:zgoda_anulowania)
      end
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
      should_assign_to :message, :ticket
    end

    context "on GET to #show" do
      setup do
        get :show, :id => messages(:zgoda_anulowania).to_param
      end
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :ticket, :message
    end

    context "on PUT to #update" do
      setup do
        put :update, :id => messages(:zgoda_anulowania), :message => { :content => "asd asd",
                                                                       :from => "client" }
      end
      should_not_change("the number of messages") { Message.count }
      should_redirect_to("parent ticket") { admin_ticket_url(assigns(:message).ticket) }
      should_set_the_flash_to /zaktualiz/ 
    end

    context "on DELETE to #destroy" do
      setup do
        @ticket = Message.first.ticket
        delete :destroy, :id => Message.first.to_param
      end
      should_change("the number of messages", :by => -1) { Message.count }
      should_redirect_to("index") { admin_ticket_url(@ticket) }
      should_set_the_flash_to /usuni/
    end

  end  
end

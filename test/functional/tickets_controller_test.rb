require 'test_helper'

class Admin::TicketsControllerTest < ActionController::TestCase
  context "TicketsController" do

    context "on GET to #index without scope" do
      setup do
        get :index
      end
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should_assign_to :tickets
      should_not_assign_to :scope
    end
    context "on GET to #index with scope" do
      setup do
        get :index, :scope => "opened"
      end
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should_assign_to :tickets
      should_assign_to :scope
    end

    context "on correct POST to #create" do
      setup do
        post :create, :ticket => { :category_id => categories(:wysylka).to_param,
                                  :employee_name => "Jack",
                                  :order_number => "123456a",
                                  :email => "asd@asd.com" }
      end
      should_create :ticket
      # should_change("the number of tickets", :by => 1) { Ticket.count } #duplicated test form above
      should_assign_to :ticket
      should_redirect_to("created ticket") { admin_ticket_url(assigns(:ticket)) }
      should_set_the_flash_to(/created/)
    end

    context "on wrong POST to #create" do
      setup do
        post :create, :ticket => { :category_id => "asd",
                                   :employee_name => "Jack",
                                   :order_number => "123456a",
                                   :email => "asd#asd.com" }
      end
      should_not_change("the number of tickets") { Ticket.count }
      should_render_template :new
      should_assign_to :ticket
      should_not_set_the_flash
    end

    context "on GET to #new" do
      setup do
        get :new
      end
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :ticket, :categories
    end

    context "on GET to #edit" do
      setup do
        get :edit, :id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
      should_assign_to :ticket, :categories
    end

    context "on GET to #show" do
      setup do
        get :show, :id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :ticket
    end

    context "on correct PUT to #update" do
      setup do
        put :update, :id => tickets(:zwrot_tomka).to_param, :ticket => { :category => categories(:wysylka),
                                                                        :employee_name => "Jack",
                                                                        :order_number => "123456a",
                                                                        :email => "asd@asd.com" }
      end
      should_not_change("the number of tickets") { Ticket.count }
      should_redirect_to("updated ticket") { admin_ticket_url(assigns(:ticket)) }
      should_set_the_flash_to(/updated/)
    end

    context "on wrong PUT to #create" do
      setup do
        put :update, :id => tickets(:zwrot_tomka).to_param, :ticket => { :category_id => "asd",
                                                                         :employee_name => "Jack",
                                                                         :order_number => "123456a",
                                                                         :email => "asd#asd.com" }
      end
      should_not_change("the number of tickets") { Ticket.count }
      should_render_template :edit
      should_not_set_the_flash
    end

    context "on DELETE to #destroy" do
      setup do
        @all_messages_qty = Message.count
        @ticket_messages_qty = Ticket.find(:first).messages.count
        delete :destroy, :id => Ticket.find(:first).to_param
      end
      should_change("the number of tickets", :by => -1) { Ticket.count }
      should_redirect_to("index") { admin_tickets_url }
      should_set_the_flash_to(/destroyed/)
      should "destroy its messages" do
        assert_equal @all_messages_qty-@ticket_messages_qty, Message.count
      end
    end

    context "on GET to #transitions" do
      setup do
        get :transitions, :type => 'basic_state_event', :id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_respond_with_content_type :json
      should_render_without_layout
    end

    context "on GET to #any_new" do
      context "when nothing new" do
        setup do
          get :any_new, nil, { :last_seen => Time.zone.now }
        end
        should_respond_with :success
        should_respond_with_content_type :html
        should_render_without_layout
        should "set responde with 'false'" do
          assert_equal 'false', @response.body
        end        
      end
      context "when new tickets arrived" do
        setup do
          new_ticket = Ticket.create(:category_id => categories(:wysylka).to_param,
                                     :employee_name => "Jack",
                                     :order_number => "123456a",
                                     :email => "asd@asd.com")
          get :any_new, nil, { :last_seen => 10.minutes.ago }
        end
        should_respond_with :success
        should_respond_with_content_type :html
        should_render_without_layout
        should "set responde with 'true'" do
          assert_equal 'true', @response.body
        end
      end
    end

  end


end

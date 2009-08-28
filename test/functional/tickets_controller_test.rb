require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  context "on GET to /tickets/" do
    setup do
      get :index
    end
    
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end

end

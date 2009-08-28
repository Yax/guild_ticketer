require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  context "TicketsController " do

    context "on GET to /tickets" do
      setup do
        get :index
      end
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
      should_assign_to :tickets
    end

    context "on POST to /tickets" do
      setup do
        post
      end
    end

    context "on GET to /tickets/new" do
      setup do
        get :new
      end
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
      should_assign_to :ticket, :categories
    end

    context "on GET to /tickets/:id/edit" do
      setup do
        get :edit, :id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
      should_assign_to :ticket, :categories
    end

    context "on GET to /tickets/:id" do
      setup do
        get :show, :id => tickets(:zwrot_tomka).to_param
      end
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
      should_assign_to :ticket
    end

  end


end

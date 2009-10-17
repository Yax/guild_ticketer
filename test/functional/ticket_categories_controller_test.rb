require 'test_helper'

class Admin::TicketCategoriesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_category" do
    assert_difference('TicketCategory.count') do
      post :create, :ticket_category => { :name => "new name", :ticket_type => "Ticket" }
    end

    assert_redirected_to admin_ticket_category_path(assigns(:ticket_category))
  end

  test "should show ticket_category" do
    get :show, :id => ticket_categories(:zwrot).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ticket_categories(:zwrot).to_param
    assert_response :success
  end

  test "should update ticket_category" do
    put :update, :id => ticket_categories(:zwrot).to_param, :ticket_category => { }
    assert_redirected_to admin_ticket_category_path(assigns(:ticket_category))
  end

  test "should destroy empty ticket_category" do
    ticket_categories(:zwrot).tickets.destroy_all
    assert_difference('TicketCategory.count', -1) do
      delete :destroy, :id => ticket_categories(:zwrot).to_param
    end

    assert_redirected_to admin_ticket_categories_path
  end

  test "should not destroy ticket_category with tickets" do
    assert_difference('TicketCategory.count', 0) do
      delete :destroy, :id => ticket_categories(:zwrot).to_param
    end
    assert !flash[:warning].nil?
    assert_redirected_to admin_ticket_categories_path
  end
end

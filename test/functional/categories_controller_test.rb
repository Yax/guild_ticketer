require 'test_helper'

class Admin::CategoriesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, :category => { :name => "new name", :ticket_type => "Ticket" }
    end

    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "should show category" do
    get :show, :id => categories(:zwrot).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categories(:zwrot).to_param
    assert_response :success
  end

  test "should update category" do
    put :update, :id => categories(:zwrot).to_param, :category => { }
    assert_redirected_to admin_category_path(assigns(:category))
  end

  test "should destroy empty category" do
    categories(:zwrot).tickets.destroy_all
    assert_difference('Category.count', -1) do
      delete :destroy, :id => categories(:zwrot).to_param
    end

    assert_redirected_to admin_categories_path
  end

  test "should not destroy category with tickets" do
    assert_difference('Category.count', 0) do
      delete :destroy, :id => categories(:zwrot).to_param
    end
    assert !flash[:warning].nil?
    assert_redirected_to admin_categories_path
  end
end

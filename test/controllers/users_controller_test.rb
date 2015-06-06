require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user2 = users(:karthik)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow cross user edit" do
    log_in_as(@user)
    get :edit, id: @user2
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow cross user update" do
    log_in_as(@user)
    patch :update, id: @user2, user: { name: "hello", email: "hello@world.com" }
    assert flash.empty?
    assert_redirected_to root_url
  end
=begin
  test "redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
=end
  test "non-admin cannot delete" do
    log_in_as(@user2)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "admin can delete" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete :destroy, id: @user2
    end
  end
end

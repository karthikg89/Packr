require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "unsucessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "",
      email: "foo@invalid",
      password: "foo",
      password_confirmation: "bar" }
    assert_template "users/edit"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    patch user_path(@user), user: { name: "Foo Bar",
      email: "foo@valid.com",
      password: "",
      password_confirmation: "" }
    assert_not flash.empty? #flash on succesful edit
    assert_redirected_to @user
    @user.reload
    assert_equal "Foo Bar", @user.name
    assert_equal "foo@valid.com", @user.email
  end

end

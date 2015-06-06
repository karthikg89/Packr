require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "present name" do
    @user.name = "         "
    assert_not @user.valid?
  end

  test "present email" do
    @user.email = "         "
    assert_not @user.valid?
  end

  test "name too long" do
    @user.name = "k" * 101
    assert_not @user.valid?
  end

  test "email too long" do
    @user.email = "k" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid email" do
    validEmails = %w[k@g.com hello@world.net user@foo.bar.dot.com]
    
    validEmails.each { |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should have worked"
    }
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "unique email addresses" do
    copy = @user.dup
    @user.save
    
    assert_not copy.valid?
    copy.email = @user.email.upcase
    assert_not copy.valid?
  end

  test "password present" do
    @user.password = "             "
    assert_not @user.valid?
  end

    
  test "password should be long enough" do
    @user.password = "hi"
    assert_not @user.valid?
  end
    
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end

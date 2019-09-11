require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'example@gmail.com', password: 'password', password_confirmation: 'password')
  end
  
  test "name should be present" do
    @user.name = ''
    assert_not @user.valid?
  end
  
  test "name shouldn't exeed 150 chars" do
    @user.name = "a" * 151
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ''
    assert_not @user.valid?
  end
  
  test "email shouldn't exeed 150 chars" do
    @user.email = "a" * 151
    assert_not @user.valid?
  end
  
  test "email should be unique and not case sensitive" do
    @user.email = 'ExAMple@gmail.com'
    @user.save
    assert_equal @user.reload.email, 'example@gmail.com'
    other_user = @user.dup
    assert_not other_user.save
  end
  
  test "email should be valid" do
    @user.email = "ssss"
    assert_not @user.valid?
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = ''
    assert_not @user.valid?
  end
  
  test "password should be atleast 8 chars" do
    @user.email = 's' * 7
    assert_not @user.valid?
  end
  
  test "password should be atmost 20 chars" do
    @user.email = 's' * 21
    assert_not @user.valid?
  end
  
  test "password confirmation should match the provided password" do
    @user.password = "foo"
    @user.password_confirmation = "bar"
    assert_not @user.valid?
  end
  
end

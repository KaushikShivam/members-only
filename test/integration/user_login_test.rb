# frozen_string_literal: true

require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test 'Log in with valid credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }

    assert_redirected_to @user
    assert flash.empty?
  end

  test 'Log in with wrong credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'pd' } }
    assert_not flash.empty?
    assert_template 'sessions/new'
  end
end

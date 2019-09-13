# frozen_string_literal: true

require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'Sign up with invalid email' do
    get signup_path
    assert_template 'users/new'
    post signup_path, params: { user: { name: 'hello', email: '',
                                        password: 'password', password_confirmation: 'password' } }
    assert_template 'users/new'
    assert_not flash.empty?
  end

  test 'Sign up with valid credentials' do
    get signup_path
    assert_template 'users/new'
    post signup_path, params: { user: { name: 'hello', email: 'hello@world.com',
                                        password: 'password', password_confirmation: 'password' } }
    follow_redirect!
    assert_template 'users/show'
  end
end

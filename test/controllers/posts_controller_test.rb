# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test 'should get new post page' do
    get new_post_path
    follow_redirect!
    assert_template 'sessions/new'
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    get new_post_path
    assert_response :success
  end

  test 'should get create' do
    get posts_path
    assert_response :success
  end

  test 'should get index' do
    get posts_path
    assert_response :success
  end
end

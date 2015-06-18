require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:michael)
  end

  test "invalid edit" do
  	log_in_as @user
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user: { name: '', email: 'foo@invalid', password: 'foo', password_confirmation: 'bar' }
  	assert_template 'users/edit'
  end

  test "successful edit" do
  	get edit_user_path(@user)
  	log_in_as @user
  	assert_redirected_to edit_user_path(@user)
  	patch user_path(@user), user: { name: "foobar", email: "foo@bar.com", password: "", password_confirmation: "" }
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal "foobar", @user.name
  	assert_equal "foo@bar.com", @user.email
  end

end

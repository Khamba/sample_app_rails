require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  	@micropost = @user.microposts.build(content: "Sample Content")
  end

  test "valid micropost" do
  	assert @micropost.valid?
  end

  test "user_id cannot be nil" do
  	@micropost.user_id = nil
  	assert_not @micropost.valid?
  end

  test "content cannot be blank" do
  	@micropost.content = "  "
  	assert_not @micropost.valid?
  end

  test "content length cannot be moer than 140" do
  	@micropost.content = "a" * 141
  	assert_not @micropost.valid?
  end

  test "order should be most recent first" do
  	assert_equal microposts(:most_recent), Micropost.first
  end

  test "associated microposts should be destroyed" do
  	@user.save
  	@user.microposts.create!(content: "Random Content")
  	assert_difference 'User.count', -1 do
  		@user.destroy
  	end
  end

end

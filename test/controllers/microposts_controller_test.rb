require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  
  def setup
  	@micropost = microposts(:orange)
  end

  test "user should be logged in before creating a micropost" do
  	assert_no_difference 'Micropost.count' do
  		post :create, microposts: { content: "Should not be saved", user_id: 1 }
  	end
  	assert_redirected_to login_url
  end

  test "user should be logged in before destroying a micropost" do
  	assert_no_difference 'Micropost.count' do
  		delete :destroy, id: @micropost.id
  	end
  	assert_redirected_to login_url 
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: micropost
    end
    assert_redirected_to root_url
  end

end

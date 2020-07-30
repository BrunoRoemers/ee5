require 'test_helper'

class Tv::ProgressAnimationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tv_progress_animation_index_url
    assert_response :success
  end

end

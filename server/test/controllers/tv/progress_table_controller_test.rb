require 'test_helper'

class Tv::ProgressTableControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tv_progress_table_index_url
    assert_response :success
  end

end

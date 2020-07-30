require 'test_helper'

class Tv::DataControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tv_data_index_url
    assert_response :success
  end

end

require 'test_helper'

class Admin::CareTakersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_care_takers_index_url
    assert_response :success
  end

end

require 'test_helper'

class Admin::PatientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_patients_index_url
    assert_response :success
  end

end

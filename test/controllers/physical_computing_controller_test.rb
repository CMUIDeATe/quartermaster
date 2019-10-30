require 'test_helper'

class PhysicalComputingControllerTest < ActionDispatch::IntegrationTest
  test "should get inventory" do
    get physical_computing_inventory_url
    assert_response :success
  end

end

require 'test_helper'

class ResourceRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resource_requests_index_url
    assert_response :success
  end

  test "should get request_physcomp_stock" do
    get resource_requests_request_physcomp_stock_url
    assert_response :success
  end

  test "should get request_resource" do
    get resource_requests_request_resource_url
    assert_response :success
  end

end

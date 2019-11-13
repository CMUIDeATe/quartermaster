require 'test_helper'

class RoomScheduleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get room_schedule_index_url
    assert_response :success
  end

  test "should get show" do
    get room_schedule_show_url
    assert_response :success
  end

end

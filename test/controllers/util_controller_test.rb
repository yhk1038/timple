require 'test_helper'

class UtilControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get util_index_url
    assert_response :success
  end

end

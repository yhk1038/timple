require 'test_helper'

class MarksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mark = marks(:one)
  end

  test "should get index" do
    get marks_url
    assert_response :success
  end

  test "should get new" do
    get new_mark_url
    assert_response :success
  end

  test "should create mark" do
    assert_difference('Mark.count') do
      post marks_url, params: { mark: { content: @mark.content, image: @mark.image, t_end: @mark.t_end, t_start: @mark.t_start, team_id: @mark.team_id, title: @mark.title, url: @mark.url, user_id: @mark.user_id, white_list: @mark.white_list } }
    end

    assert_redirected_to mark_url(Mark.last)
  end

  test "should show mark" do
    get mark_url(@mark)
    assert_response :success
  end

  test "should get edit" do
    get edit_mark_url(@mark)
    assert_response :success
  end

  test "should update mark" do
    patch mark_url(@mark), params: { mark: { content: @mark.content, image: @mark.image, t_end: @mark.t_end, t_start: @mark.t_start, team_id: @mark.team_id, title: @mark.title, url: @mark.url, user_id: @mark.user_id, white_list: @mark.white_list } }
    assert_redirected_to mark_url(@mark)
  end

  test "should destroy mark" do
    assert_difference('Mark.count', -1) do
      delete mark_url(@mark)
    end

    assert_redirected_to marks_url
  end
end

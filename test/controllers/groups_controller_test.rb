require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get groups_url
    assert_response :success
  end

  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post groups_url, params: { group: { background_img: @group.background_img, description: @group.description, invite_code: @group.invite_code, name: @group.name, profile_img: @group.profile_img } }
    end

    assert_redirected_to group_url(Group.last)
  end

  test "should show group" do
    get group_url(@group)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :success
  end

  test "should update group" do
    patch group_url(@group), params: { group: { background_img: @group.background_img, description: @group.description, invite_code: @group.invite_code, name: @group.name, profile_img: @group.profile_img } }
    assert_redirected_to group_url(@group)
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete group_url(@group)
    end

    assert_redirected_to groups_url
  end
end

require "test_helper"

class ItemtestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @itemtest = itemtests(:one)
  end

  test "should get index" do
    get itemtests_url
    assert_response :success
  end

  test "should get new" do
    get new_itemtest_url
    assert_response :success
  end

  test "should create itemtest" do
    assert_difference('Itemtest.count') do
      post itemtests_url, params: { itemtest: { description: @itemtest.description, name: @itemtest.name, user_id: @itemtest.user_id } }
    end

    assert_redirected_to itemtest_url(Itemtest.last)
  end

  test "should show itemtest" do
    get itemtest_url(@itemtest)
    assert_response :success
  end

  test "should get edit" do
    get edit_itemtest_url(@itemtest)
    assert_response :success
  end

  test "should update itemtest" do
    patch itemtest_url(@itemtest), params: { itemtest: { description: @itemtest.description, name: @itemtest.name, user_id: @itemtest.user_id } }
    assert_redirected_to itemtest_url(@itemtest)
  end

  test "should destroy itemtest" do
    assert_difference('Itemtest.count', -1) do
      delete itemtest_url(@itemtest)
    end

    assert_redirected_to itemtests_url
  end
end

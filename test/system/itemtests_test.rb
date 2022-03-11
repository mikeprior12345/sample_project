require "application_system_test_case"

class ItemtestsTest < ApplicationSystemTestCase
  setup do
    @itemtest = itemtests(:one)
  end

  test "visiting the index" do
    visit itemtests_url
    assert_selector "h1", text: "Itemtests"
  end

  test "creating a Itemtest" do
    visit itemtests_url
    click_on "New Itemtest"

    fill_in "Description", with: @itemtest.description
    fill_in "Name", with: @itemtest.name
    fill_in "User", with: @itemtest.user_id
    click_on "Create Itemtest"

    assert_text "Itemtest was successfully created"
    click_on "Back"
  end

  test "updating a Itemtest" do
    visit itemtests_url
    click_on "Edit", match: :first

    fill_in "Description", with: @itemtest.description
    fill_in "Name", with: @itemtest.name
    fill_in "User", with: @itemtest.user_id
    click_on "Update Itemtest"

    assert_text "Itemtest was successfully updated"
    click_on "Back"
  end

  test "destroying a Itemtest" do
    visit itemtests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Itemtest was successfully destroyed"
  end
end

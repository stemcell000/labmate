require "application_system_test_case"

class DocTypesTest < ApplicationSystemTestCase
  setup do
    @doc_type = doc_types(:one)
  end

  test "visiting the index" do
    visit doc_types_url
    assert_selector "h1", text: "Doc Types"
  end

  test "creating a Doc type" do
    visit doc_types_url
    click_on "New Doc Type"

    click_on "Create Doc type"

    assert_text "Doc type was successfully created"
    click_on "Back"
  end

  test "updating a Doc type" do
    visit doc_types_url
    click_on "Edit", match: :first

    click_on "Update Doc type"

    assert_text "Doc type was successfully updated"
    click_on "Back"
  end

  test "destroying a Doc type" do
    visit doc_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Doc type was successfully destroyed"
  end
end

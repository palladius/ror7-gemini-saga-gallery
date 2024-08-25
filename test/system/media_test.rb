require "application_system_test_case"

class MediaTest < ApplicationSystemTestCase
  setup do
    @medium = media(:one)
  end

  test "visiting the index" do
    visit media_url
    assert_selector "h1", text: "Media"
  end

  test "should create medium" do
    visit media_url
    click_on "New medium"

    fill_in "Caption", with: @medium.caption
    fill_in "Dimensions", with: @medium.dimensions
    fill_in "File size", with: @medium.file_size
    fill_in "Gallery", with: @medium.gallery_id
    fill_in "Gemini description", with: @medium.gemini_description
    fill_in "Gemini quality", with: @medium.gemini_quality
    fill_in "Gemini relevance", with: @medium.gemini_relevance
    fill_in "Gemini text", with: @medium.gemini_text
    fill_in "Media type", with: @medium.media_type
    fill_in "Original filename", with: @medium.original_filename
    fill_in "Path", with: @medium.path
    fill_in "Title", with: @medium.title
    fill_in "User", with: @medium.user_id
    click_on "Create Medium"

    assert_text "Medium was successfully created"
    click_on "Back"
  end

  test "should update Medium" do
    visit medium_url(@medium)
    click_on "Edit this medium", match: :first

    fill_in "Caption", with: @medium.caption
    fill_in "Dimensions", with: @medium.dimensions
    fill_in "File size", with: @medium.file_size
    fill_in "Gallery", with: @medium.gallery_id
    fill_in "Gemini description", with: @medium.gemini_description
    fill_in "Gemini quality", with: @medium.gemini_quality
    fill_in "Gemini relevance", with: @medium.gemini_relevance
    fill_in "Gemini text", with: @medium.gemini_text
    fill_in "Media type", with: @medium.media_type
    fill_in "Original filename", with: @medium.original_filename
    fill_in "Path", with: @medium.path
    fill_in "Title", with: @medium.title
    fill_in "User", with: @medium.user_id
    click_on "Update Medium"

    assert_text "Medium was successfully updated"
    click_on "Back"
  end

  test "should destroy Medium" do
    visit medium_url(@medium)
    click_on "Destroy this medium", match: :first

    assert_text "Medium was successfully destroyed"
  end
end

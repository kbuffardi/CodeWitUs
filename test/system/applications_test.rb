require "application_system_test_case"

class ApplicationsTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    visit home_url
    assert_selector "h1", text: "I want to learn about Coding"
  end
  test "different header" do
    visit home_url
    assert_selector "h1", text: "Lorem Ipsum with if statements"
  end
end

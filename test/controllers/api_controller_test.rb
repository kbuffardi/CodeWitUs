require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  #fix this test
  test "interest URL" do
    post '/interest'
    #:redirect - Status code was in the 300-399 range
    assert_response :success
  end
end

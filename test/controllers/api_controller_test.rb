require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "incorrect url" do
    get '/incorrect'
    #:redirect - Status code was in the 300-399 range
    assert_response :redirect
  end
  test "interst URL" do
    post '/interest'
    #:redirect - Status code was in the 300-399 range
    assert_response :redirect
  end
  
end

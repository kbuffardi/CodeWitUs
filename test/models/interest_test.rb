require 'test_helper'

class InterestTest < ActiveSupport::TestCase
	test "valid attributes should save entry" do
		interest = Interest.new("id":2, "interest_name":"video games", "interest_count":0)
		assert interest.save
	end
end

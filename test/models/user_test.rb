require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should be 9 users in db" do
    User.create! (
      {
      pseudo: 'test',
      email: "test@yes.com",
      password: "123456",
      }
    )
    assert User.all.count == 1
  end
end

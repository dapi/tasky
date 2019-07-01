# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test 'register user and accept invites' do
    email = generate :email

    board = create :board
    create :invite, account: board.account, board: board, email: email

    post users_url, params: { user: { email: email, name: 'test' } }
    assert_response :redirect
    user = User.find_by(email: email)
    assert user.present?
    assert_includes board.account.members, user
    assert_includes board.members, user
  end
end

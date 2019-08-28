# frozen_string_literal: true

require 'test_helper'

class BoardMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
    @account = create :account, owner: @current_user
    @board = create :board, account: @account
  end

  test 'should render "new" template if there are problem with form' do
    post board_members_url(@board, subdomain: @account.subdomain), params: { invite_form: { emails: '' } }
    assert_response :success
  end
end

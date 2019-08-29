# frozen_string_literal: true

require 'test_helper'

class BoardsAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    account_host!
  end

  test 'POST /api/v1/boards' do
    title = generate :title
    some_value = 123
    metadata = { test: some_value }
    post '/api/v1/boards', params: { title: title, metadata: metadata.to_json }
    assert response.successful?
    assert @current_account.boards.one?
    assert_equal some_value, @current_account.boards.last.metadata['test']
  end
end

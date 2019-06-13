# frozen_string_literal: true

require 'test_helper'

class MetadataSupportTest < ActiveSupport::TestCase
  test 'jsonb' do
    account = create :account, metadata: { a: 1 }

    assert_equal({ 'a' => 1 }, account.metadata)
    assert Account.metadata_query('@>', a: 1).exists?
    assert_not Account.metadata_query('@>', b: 1).exists?
    assert Account.metadata_query('?', 'a').exists?
  end

  test 'jsonb must be a hash' do
    assert_raises do
      create :account, metadata: []
    end
  end
end

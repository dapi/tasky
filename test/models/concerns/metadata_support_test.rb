# frozen_string_literal: true

require 'test_helper'

class MetadataSupportTest < ActiveSupport::TestCase
  test 'jsonb' do
    account = create :account, metadata: { a: 1 }

    assert_equal({ 'a' => 1 }, account.metadata)
    assert Account.by_metadata('@>', a: 1).exists?
    assert_not Account.by_metadata('@>', b: 1).exists?
    assert Account.by_metadata('?', 'a').exists?
  end

  test 'jsonb must be a hash' do
    assert_raises do
      create :account, metadata: []
    end
  end
end

# frozen_string_literal: true

require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test 'creatable' do
    assert create :board
  end
end

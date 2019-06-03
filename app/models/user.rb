# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
end

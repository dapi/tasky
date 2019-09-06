# frozen_string_literal: true

class SetupNicknames < ActiveRecord::Migration[5.2]
  def up
    User.where(nickname: [nil, '']).find_each do |u|
      u.send :give_nickname
      u.save!
    end
  end

  def down
  end
end

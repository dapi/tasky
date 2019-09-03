# frozen_string_literal: true

class AddLocaleToInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :locale, :string

    Invite.find_each do |i|
      i.update_column :locale, i.inviter.locale
    end

    change_column_null :invites, :locale, false
  end
end

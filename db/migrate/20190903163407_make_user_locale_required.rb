# frozen_string_literal: true

class MakeUserLocaleRequired < ActiveRecord::Migration[5.2]
  def change
    User.where(locale: nil).update_all locale: :en
    change_column_null :users, :locale, false
  end
end

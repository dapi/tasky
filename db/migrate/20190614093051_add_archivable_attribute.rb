# frozen_string_literal: true

class AddArchivableAttribute < ActiveRecord::Migration[5.2]
  def change
    %i[accounts boards lanes tasks].each do |table|
      add_column table, :archived_at, :timestamp
    end
  end
end

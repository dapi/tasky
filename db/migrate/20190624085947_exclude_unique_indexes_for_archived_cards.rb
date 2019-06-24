class ExcludeUniqueIndexesForArchivedCards < ActiveRecord::Migration[5.2]
  def change
    remove_index :cards, [:lane_id, :position]
    add_index :cards, [:lane_id, :position], unique: true, where: 'archived_at is null'
  end
end

class CreatePgSearchDocuments < ActiveRecord::Migration[5.2]
  def self.up
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    execute "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;"
    say_with_time("Creating table for pg_search multisearch") do
      create_table :pg_search_documents do |t|
        t.text :content
        t.uuid :account_id
        t.belongs_to :searchable, polymorphic: true, index: true
        t.timestamps null: false
      end
    end
  end

  def self.down
    execute "DROP EXTENSION IF EXISTS pg_trgm;"
    execute "DROP EXTENSION IF EXISTS fuzzystrmatch;"
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents
    end
  end
end

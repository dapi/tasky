class AddNumberToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :number, :integer

    create_trigger

    Account.find_each do |a|
      number = 0
      a.tasks.order(:created_at).each do |t|
        t.update_column :number, number+=1
      end
    end

    add_index :tasks, [:account_id, :number], unique: true
    change_column :tasks, :number, :integer, null: false
  end

  def down
    remove_column :tasks, :number

    execute 'DROP TRIGGER generate_task_number ON tasks;'
    execute 'DROP FUNCTION generate_task_number;'
  end

  private

  def create_trigger
    execute %{
    CREATE OR REPLACE FUNCTION generate_task_number() RETURNS TRIGGER AS $generate_task_number$
    DECLARE
      last_number integer;
    BEGIN
      SELECT max(number) FROM tasks WHERE account_id=NEW.account_id INTO last_number;
      IF last_number is NULL THEN
        NEW.number := 1;
      ELSE
        NEW.number := last_number + 1;
      END IF;
      RETURN NEW;
    END
    $generate_task_number$ LANGUAGE plpgsql;

    DROP TRIGGER IF EXISTS generate_task_number ON tasks;
    CREATE TRIGGER generate_task_number
    BEFORE INSERT ON tasks FOR EACH ROW EXECUTE PROCEDURE generate_task_number();
    }
  end
end

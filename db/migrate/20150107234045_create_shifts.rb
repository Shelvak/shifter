class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :worker_id, null: false
      t.boolean :kind, default: false

      t.timestamps
    end

    add_index :shifts, :worker_id
  end
end

class CreateAllotments < ActiveRecord::Migration
  def change
    create_table :allotments do |t|
      t.integer :owner_id, null: false
      t.string :place, null: false

      t.timestamps
    end

    add_index :allotments, :owner_id
  end
end

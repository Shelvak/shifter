class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :identification, null: false
      t.string :address
      t.string :phone
      t.string :occupation

      t.timestamps
    end

    add_index :workers, :identification
  end
end

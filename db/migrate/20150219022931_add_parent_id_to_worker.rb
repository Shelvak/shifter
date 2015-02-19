class AddParentIdToWorker < ActiveRecord::Migration
  def change
    add_column :workers, :parent_id, :integer
  end
end

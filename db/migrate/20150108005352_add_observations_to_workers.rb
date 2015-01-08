class AddObservationsToWorkers < ActiveRecord::Migration
  def change
    add_column :workers, :observations, :text
  end
end

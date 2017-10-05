class ChangeWorkertoworkers < ActiveRecord::Migration[5.1]
  def change

    rename_table :worker, :workers
  end
end

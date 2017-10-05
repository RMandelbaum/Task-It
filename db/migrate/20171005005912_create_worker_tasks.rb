class CreateWorkerTasks < ActiveRecord::Migration[5.1]
  def change

    create_table :worker_tasks do |t|
      t.integer :task_id
      t.integer :worker_id
    end
  end
end

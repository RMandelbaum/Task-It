class CreateWorker < ActiveRecord::Migration[5.1]
  def change

    create_table :worker do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :boss_id
    end

  end
end

class CreateEmployee < ActiveRecord::Migration[5.1]
  def change

    create_table :employees do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :employer_id
    end

  end
end

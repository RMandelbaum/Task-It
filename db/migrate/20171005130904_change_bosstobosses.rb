class ChangeBosstobosses < ActiveRecord::Migration[5.1]
  def change

    rename_table :boss, :bosses 
  end
end

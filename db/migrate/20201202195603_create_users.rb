class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.timestamps
    end

    add_index :users, [:phone_number, :last_name, :first_name], unique: true
  end
end

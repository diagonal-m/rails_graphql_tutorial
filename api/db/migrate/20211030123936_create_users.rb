class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :profile

      t.timestamps
    end
  end
end

class CreateUsersRoles < ActiveRecord::Migration
  def change
    create_table :users_roles do |t|
      t.integer :userId
      t.string :roleName
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

class AddFirstLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstName, :text
    add_column :users, :lastName, :text
    add_column :users, :langKey, :text
  end
end

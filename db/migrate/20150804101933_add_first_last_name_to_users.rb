class AddFirstLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstName, :text
    add_column :users, :lastName, :text
  end
end

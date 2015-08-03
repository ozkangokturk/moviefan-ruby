class CreateMovieFans < ActiveRecord::Migration
  def change
    create_table :movie_fans, :id => false do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

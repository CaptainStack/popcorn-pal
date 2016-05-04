class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.references :user, null: false
      t.references :movie, null: false
      t.boolean :on_watchlist, default: false
      t.timestamps null: false
    end
  end
end

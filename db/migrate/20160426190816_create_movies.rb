class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string    :imdb_id
      t.string    :title
      t.date      :release_date
      t.text      :overview
      t.string    :poster_path
      t.string    :backdrop_path
      t.float     :popularity
      t.boolean   :adult
      t.timestamps null: false
    end
  end
end

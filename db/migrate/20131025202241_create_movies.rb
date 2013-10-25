class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :unique_id
      t.string :title
      t.string :thumbnail
      t.text :description
      t.timestamps
    end
  end
end

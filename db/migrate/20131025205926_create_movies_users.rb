class CreateMoviesUsers < ActiveRecord::Migration
  def change
    create_table :movies_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :movie, index: true
    end

    add_index :movies_users, [:movie_id, :user_id], unique: true
  end
end

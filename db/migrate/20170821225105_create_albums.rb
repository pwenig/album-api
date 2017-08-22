class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :album
      t.string :genre
      t.string :year
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end

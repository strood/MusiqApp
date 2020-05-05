class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
    t.integer :band_id, presence: true
    t.string :title, presence: true
    t.integer :year, presence: true
    t.boolean :live, default: false

    t.timestamps
    end

    add_index :albums, :band_id

  end
end

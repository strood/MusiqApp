class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.integer :ord, null: false
      t.boolean :bonus, null: false, default: false
      t.text :lyrics, length: { maximum: 500 }
      t.belongs_to :album, index: { unique: true }, foreign_key: true

      t.timestamps
    end

  end
end

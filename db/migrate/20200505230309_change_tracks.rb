class ChangeTracks < ActiveRecord::Migration[5.2]
  def change
    remove_index :tracks, [:album_id]
  end
end

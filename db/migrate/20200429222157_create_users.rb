class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, presence: true, unique: true
      t.string :session_token, presence: true
      t.string :password_digest, presence: true

      t.timestamps
    end

    add_index :users, :session_token
  end
end

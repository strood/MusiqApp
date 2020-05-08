class AddActivationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    # Also adding in the activation token here as i forgot to in last migraiton
    add_column :users, :activation_token, :string, null: false
  end
end

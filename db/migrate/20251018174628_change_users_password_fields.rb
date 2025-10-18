
class ChangeUsersPasswordFields < ActiveRecord::Migration[7.1]
  def up
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    remove_column :users, :remember_created_at if column_exists?(:users, :remember_created_at)

    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)
  end

  def down
    add_column :users, :encrypted_password, :string, null: false, default: ""
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime

    remove_column :users, :password_digest

    add_index :users, :reset_password_token, unique: true
  end
end

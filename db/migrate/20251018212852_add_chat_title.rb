class AddChatTitle < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :title, :string, default: ''
  end
end

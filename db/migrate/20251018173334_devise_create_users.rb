# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Devise fields
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Additional patient info
      t.string  :first_name, null: false
      t.string  :last_name, null: false
      t.string  :gender, null: false
      t.date    :date_of_birth, null: false
      t.string  :country, null: false
      t.string  :city, null: false
      t.string  :phone_number, null: false
      t.integer :height_cm, null: false
      t.integer :weight_kg, null: false
      t.string  :blood_type
      t.string  :smoking_status
      t.string  :alcohol_use
      t.string  :activity_level
      t.text    :known_allergies
      t.text    :chronic_conditions

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end

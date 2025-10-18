class AddPregnancyStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :pregnancy_status, :string, default: "Not Pregnant"
  end
end

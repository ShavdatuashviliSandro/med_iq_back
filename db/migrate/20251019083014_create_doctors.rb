class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :full_name
      t.string :specialty
      t.string :address
      t.string :clinic
      t.float :rating
      t.jsonb :calendar
      t.string :image_url

      t.timestamps
    end
  end
end

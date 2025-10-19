class AddRatingCountToDoctor < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :rating_count, :integer, default: 0
    add_column :doctors, :average_rating, :float, default: 0
  end
end

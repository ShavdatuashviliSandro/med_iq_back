class AddUserLastRatingToBooking < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :user_last_rating, :float, default: 0
  end
end

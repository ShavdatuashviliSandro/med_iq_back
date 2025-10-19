class AddDoctorIdToBooking < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :doctor, foreign_key: true
  end
end

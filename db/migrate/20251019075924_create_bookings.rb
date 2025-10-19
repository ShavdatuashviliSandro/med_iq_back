class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.string :doctor_name
      t.string :specialty
      t.datetime :appointment_date
      t.string :appointment_slot
      t.string :address
      t.string :status

      t.timestamps
    end
  end
end

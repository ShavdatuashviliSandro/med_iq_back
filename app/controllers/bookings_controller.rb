class BookingsController < ApplicationController
  def index
    bookings = Booking.where(user_id: @current_user.id)

    render json: bookings
  end

  def create
    booking = Booking.create!(create_params)

    render json: booking
  end

  private

  def create_params
    params.require(:booking).permit(:doctor_name, :specialty, :appointment_date, :appointment_slot, :address, :user_id)
  end
end

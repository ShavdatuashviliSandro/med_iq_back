class BookingsController < ApplicationController
  def index
    bookings = Booking.where(user_id: @current_user.id)

    render json: bookings
  end

  def create
    booking = Booking.create!(create_params)
    booking.pending!

    render json: booking
  end

  def cancel_booking
    booking = Booking.find(params[:id])

    booking.update(status: :cancelled)

    render json: booking
  end

  def rate_booking_doctor
    doctor = Doctor.find(params[:id])

    rating_count = doctor.rating_count += 1
    doctor.rating += params[:rating]

    doctor.update!(average_rating: doctor.rating / rating_count)
    Booking.find(params[:booking_id]).update(user_last_rating: params[:rating])

    render json: doctor
  end

  private

  def create_params
    params.require(:booking).permit(:doctor_name, :specialty, :appointment_date, :appointment_slot, :address, :user_id,
                                    :doctor_id)
  end
end

# frozen_string_literal: true
module Bookings
  class BookingsService
    def initialize(current_user = nil, params = nil)
      @current_user = current_user
      @params = params
    end

    def index
      Booking.where(user_id: @current_user.id)
    end

    def create
      booking = Booking.create!(create_params)
      booking.pending!

      booking
    end

    def cancel_booking
      booking = Booking.find(@params[:id])
      booking.update(status: :cancelled)

      booking
    end

    def rate_booking_doctor
      doctor = Doctor.find(@params[:id])

      rating_count = doctor.rating_count += 1
      doctor.rating += @params[:rating]

      doctor.update!(average_rating: doctor.rating / rating_count)
      Booking.find(@params[:booking_id]).update(user_last_rating: @params[:rating])
    end
  end
end

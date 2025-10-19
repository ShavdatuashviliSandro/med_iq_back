class BookingsController < ApplicationController
  def index
    data = Bookings::BookingsService.new(@current_user).index

    render json: data
  end

  def create
    data = Bookings::BookingsService.new(@current_user, create_params).create

    render json: data
  end

  def cancel_booking
    data = Bookings::BookingsService.new(@current_user, params).cancel_booking

    render json: data
  end

  def rate_booking_doctor
    data = Bookings::BookingsService.new(@current_user, params).rate_booking_doctor

    render json: data
  end

  private

  def create_params
    params.require(:booking).permit(:doctor_name, :specialty, :appointment_date, :appointment_slot, :address, :user_id,
                                    :doctor_id)
  end
end

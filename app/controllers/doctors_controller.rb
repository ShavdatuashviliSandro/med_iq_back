class DoctorsController < ApplicationController
  def fetch_doctors
    data = Doctors::DoctorsService.new(params).fetch_doctors

    render json: data
  end
end

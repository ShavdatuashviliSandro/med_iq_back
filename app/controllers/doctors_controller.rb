class DoctorsController < ApplicationController
  def fetch_doctors
    doctor_json = Doctor.all.as_json

    specialties = params[:specialty]

    doctors = if specialties.any?
                doctor_json.select { |doc| specialties.include?(doc['specialty']) }
              else
                doctor_json.select { |doc| doc['specialty'] == 'General Practitioner' }
              end

    render json: doctors
  end
end

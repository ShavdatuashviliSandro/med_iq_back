module Doctors
  class DoctorsService
    def initialize(params)
      @params = params
    end
    def fetch_doctors
      doctor_json = Doctor.all.as_json

      specialties = @params[:specialty]

      if specialties.any?
        doctor_json.select { |doc| specialties.include?(doc['specialty']) }
      else
        doctor_json.select { |doc| doc['specialty'] == 'General Practitioner' }
      end
    end
  end
end
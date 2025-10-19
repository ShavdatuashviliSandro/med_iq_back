class DoctorsController < ApplicationController
  def fetch_doctors
    doctor_json = [
      { "id": 1, "full_name": 'Dr. Giorgi Beridze', "specialty": 'Pediatric Neurologist', "address": '12 Rustaveli Ave, Tbilisi, Georgia', "clinic": 'Tbilisi Children’s Health Center', "rating": 4.8, "calendar": { "free_days": [2, 4, 6, 9, 15, 22], "free_times": %w[09:30 10:00 11:30 15:00 16:30] }, "image_url": 'https://randomuser.me/api/portraits/med/men/32.jpg' },
      { "id": 2, "full_name": 'Dr. Nino Kapanadze', "specialty": 'Cardiologist', "address": '8 Chavchavadze St, Batumi, Georgia', "clinic": 'Batumi Cardio Clinic', "rating": 4.6, "calendar": { "free_days": [1, 5, 7, 10, 16, 21, 27], "free_times": ['09:00', '10:30', '14:00', '15:30', '17:00'] }, "image_url": 'https://randomuser.me/api/portraits/med/women/12.jpg' },
      { "id": 3, "full_name": 'Dr. Levan Chikhladze', "specialty": 'Dermatologist', "address": '23 Bagrationi St, Kutaisi, Georgia', "clinic": 'Kutaisi Skin & Aesthetics Center', "rating": 4.9, "calendar": { "free_days": [3, 6, 9, 13, 17, 23], "free_times": ['09:00', '09:30', '10:00', '11:00', '16:00', '16:30'] }, "image_url": 'https://randomuser.me/api/portraits/med/men/44.jpg' },
      { "id": 4, "full_name": 'Dr. Tamar Abashidze', "specialty": 'Pediatric Orthopedic Surgeon', "address": '5 Kostava St, Tbilisi, Georgia', "clinic": 'NeuroCare Clinic', "rating": 4.7, "calendar": { "free_days": [2, 3, 7, 12, 18, 24], "free_times": ['10:00', '11:30', '14:00', '15:30', '17:00'] }, "image_url": 'https://randomuser.me/api/portraits/med/women/35.jpg' },
      { "id": 5, "full_name": 'Dr. Irakli Shvelidze', "specialty": 'Pediatric Orthopedic Surgeon', "address": '7 Baratashvili St, Zugdidi, Georgia', "clinic": 'Zugdidi Orthopedic Center', "rating": 4.5, "calendar": { "free_days": [1, 4, 8, 13, 19, 25, 29], "free_times": ['09:00', '09:30', '10:30', '11:00', '15:00', '16:30'] }, "image_url": 'https://randomuser.me/api/portraits/med/men/41.jpg' }
    ]

    specialties = params[:specialty]

    doctors = if specialties.any?
                doctor_json.select { |doc| specialties.include?(doc[:specialty]) }
              else
                doctor_json
              end

    render json: doctors
  end
end

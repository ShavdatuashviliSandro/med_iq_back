class Booking < ApplicationRecord
  enum status: { pending: 'Upcoming', confirmed: 'Confirmed', cancelled: 'Cancelled' }
end

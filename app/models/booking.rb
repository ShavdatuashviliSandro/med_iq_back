class Booking < ApplicationRecord
  enum status: { pending: 'Upcoming', finished: 'Finished', cancelled: 'Cancelled' }
end

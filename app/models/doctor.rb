class Doctor < ApplicationRecord
  store_accessor :calendar, :free_days, :free_times
end

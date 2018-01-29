class Order < ApplicationRecord
  scope :completed, -> { where('completed_at is not null') }
end

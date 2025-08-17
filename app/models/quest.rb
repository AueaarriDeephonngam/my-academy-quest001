class Quest < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1 }

  scope :completed, -> { where(done: true) }
  scope :pending, -> { where(done: false) }
end

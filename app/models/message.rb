class Message < ApplicationRecord
  validates :content, presence: true, length: {maximum: 100}
  belongs_to :user
  belongs_to :room
end

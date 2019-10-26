class MicropostHashtag < ApplicationRecord
  belongs_to :micropost
  belongs_to :hashtag
  validates  :micropost_id, presence: true
  validates  :hashtag_id,   presence: true
end
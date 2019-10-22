class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  #default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
  validate  :picture_size

    def like_user(user_id)
      likes.find_by(user_id: user_id)
    end

  private
    def picture_size
      if picture.size > 5.megabyte
        errors.add(:picture, "5MB以下の画像を投稿してください！")
      end
    end

    def self.search(search)
      if search
        Micropost.where(['content LIKE ?', "%#{search}%"])
      else
        Micropost.all
      end
    end

    
end

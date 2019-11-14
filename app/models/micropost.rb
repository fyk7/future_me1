class Micropost < ApplicationRecord
  has_and_belongs_to_many :tags, dependent: :destroy
  belongs_to :user
  has_many :likes, dependent: :destroy
  #default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 200}
  validate :picture_size
  has_many :comments, dependent: :destroy
  enum micropost_category: {大学生活前半: 1, 大学生活後半: 2, 就活中: 3, 社会人ルーキー: 4, 社会人ミドル: 5, その他: 6}

    def like_user(user_id)
      likes.find_by(user_id: user_id)
    end

    after_create do
      micropost = Micropost.find_by(id: self.id)
      hashtags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#').delete('＃'))
        micropost.tags << tag
      end
    end
  
    before_update do 
      micropost = Micropost.find_by(id: self.id)
      micropost.hashtags.clear
      hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#').delete('＃'))
        micropost.tags << tag
      end
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

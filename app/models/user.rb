#require_dependency '../validators/email_address_validator.rb'

class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  attr_accessor :remember_token
  mount_uploader :image, ImageUploader
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :email_downcase, unless: :uid?
  validates :name,  presence: true, unless: :uid?, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, unless: :uid?, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    #email_address: true, #複数モデルで使用可能なvalidator作成
                    uniqueness: { case_sensitive: false }
  has_secure_password  validations: false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  enum user_category: {大学生活前半: 1, 大学生活後半: 2, 就活中: 3, 社会人ルーキー: 4, 社会人ミドル: 5, その他: 6}


  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.user_category = 'その他'
      if user.image_url?
        user.image_name = image
      else
        user.image_name = "default_user.jpeg"
      end
    end
  end

  private

  def email_downcase
    self.email.downcase!
  end

end

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # ↓↓画像
  # ↓↓投稿バリデーション

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy, through: :books
  # いいね機能でのランキング
  has_many :favorited_books, through: :favorites, source: :book

  # バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true
  validates :introduction, length: { maximum: 200 }, presence: true
  attachment :profile_image, destroy: false

  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end

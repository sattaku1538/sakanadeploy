class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  # ↓↓画像
  attachment :profile_image, destroy: false
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_many :books, dependent: :destroy
   
   
  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
end

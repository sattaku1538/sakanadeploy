class Book < ApplicationRecord

  belongs_to :customer
  attachment :image
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :book_comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
  validates :place, presence: true, length: { maximum: 50 }
  validates :explanation, presence: true, length: { maximum: 50 }
  
  validates :image, presence: true


  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end

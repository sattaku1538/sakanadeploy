class Book < ApplicationRecord

  belongs_to :customer
  attachment :image
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :book_comments, dependent: :destroy

  validates :title, :place, :explanation, presence: true
  validates :image, presence: true


  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end

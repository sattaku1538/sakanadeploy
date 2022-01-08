class BookComment < ApplicationRecord
    belongs_to :customer
    belongs_to :book
    validates :comment, presence: true, length: { maximum: 200 }
end

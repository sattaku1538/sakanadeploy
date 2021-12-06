class Book < ApplicationRecord
    
  belongs_to :customer
  attachment :image
  
end

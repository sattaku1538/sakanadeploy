class Public::FavoritesController < ApplicationController
    
  before_action :authenticate_customer!
    
#   def create
#     book = Book.find(params[:book_id])
#     favorite = current_customer.favorites.new(book_id: book.id)
#     favorite.save
#     redirect_back(fallback_location: root_path)
#   end

#   def destroy
#     book = Book.find(params[:book_id])
#     favorite = current_customer.favorites.find_by(book_id: book.id)
#     favorite.destroy
#     redirect_back(fallback_location: root_path)
#   end
    
    
    
  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(customer_id: current_customer.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(customer_id: current_customer.id)
    favorite.destroy
    # redirect_to request.referer
  end
    
end

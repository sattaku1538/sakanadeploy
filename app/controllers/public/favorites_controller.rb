class Public::FavoritesController < ApplicationController
  # before_action :authenticate_customer!

  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(customer_id: current_customer.id)
    favorite.save
    # redirect_to request.referer  AJAX処理のため、コメントアウト
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(customer_id: current_customer.id)
    favorite.destroy
    # redirect_to request.referer AJAX処理のため、コメントアウト
  end

end

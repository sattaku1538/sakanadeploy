class Admin::BooksController < ApplicationController
  
  
  def show
    @book = Book.find(params[:id])
  end
  
  def index
  #   # 投稿したものを表示する。
    @books = Book.all
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :place, :explanation, :image)
  end

  
end

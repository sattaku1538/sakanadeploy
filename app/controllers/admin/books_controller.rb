class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!,except: [:new_admin_session_path]

  def show
    @book = Book.find(params[:id])
  end

  def index
  #   # 投稿したものを表示する。
    @books = Book.all
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:admin] = "＜不正な投稿を削除しました。＞"
    redirect_to admin_root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :place, :explanation, :image)
  end


end

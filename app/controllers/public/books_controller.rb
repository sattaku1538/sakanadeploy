class Public::BooksController < ApplicationController
  before_action :authenticate_customer!,except: [:top, :index]

  def new
    @book = Book.new
    @customer = current_customer
  end

  def show
    @customer = current_customer
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @customer = current_customer
  #   # 投稿したものを表示する。
    @books = Book.all
  #   # ↓↓いいね数の順番に投稿を表示。
    to  = Time.current.at_end_of_day
    from  = (to - 13.day).at_beginning_of_day
    @books = Book.includes(:favorited_customers).
      sort {|a,b|
        b.favorited_customers.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_customers.includes(:favorites).where(created_at: from...to).size
      }
  end

  def create
    @customer = current_customer
    @book = Book.new(book_params)
    @book.customer_id = current_customer.id
    if @book.save
      redirect_to public_books_path, notice: "You have created book successfully."
    else
      @books = Book.all
      render 'new'
    end
  end

  def edit
    @customer = current_customer
    @book = Book.find(params[:id])
  end

  def update
    @customer = current_customer
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:edit] = "<投稿を更新しました。>"
      redirect_to public_books_path(@book)
    else
       flash[:notice] = "<更新されていません。>"
       render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:destroy] = "<投稿を削除しました。>"
    redirect_to public_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :place, :explanation, :image)
  end

  # def ensure_correct_user
  #   @book = Book.find(params[:id])
  #   unless @book.user == current_user
  #     redirect_to public_books_path
  #   end
  # end
end

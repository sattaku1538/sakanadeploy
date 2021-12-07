class Public::BooksController < ApplicationController
  def new
    @book = Book.new(book_params)
  end
  
  def show
    @book = Book.find(params[:id])
    # @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    # 投稿したものを表示する。
    # @books = Book.all.sort {|a,b| b.favorites.count <=> a.favorites.count} いいね数の順番に投稿を表示。
    # to  = Time.current.at_end_of_day
    # from  = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorited_users).
    #   sort {|a,b| 
    #     b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
    #     a.favorited_users.includes(:favorites).where(created_at: from...to).size
    #   }
  end

  def create
    @book.customer_id = current_customer.id
    if @book.save
      redirect_to public_books_path, notice: "You have created book successfully."
    else
      @books = Book.all
      render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params[:id])
       redirect_to public_books_path(@book), notice: "You have updated book successfully."
    else
       render "edit"
    end
  end

  def destroy
    @book.destroy
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

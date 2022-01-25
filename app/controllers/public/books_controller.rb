class Public::BooksController < ApplicationController
  before_action :authenticate_customer!,except: [:top, :index]
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

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
  #   # ↓↓いいね数の順番に投稿を表示。
    to  = Time.current.at_end_of_day
    from  = (to - 13.day).at_beginning_of_day
    @books = Book.includes(:favorited_customers).
      sort {|a,b|
        b.favorited_customers.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_customers.includes(:favorites).where(created_at: from...to).size
      }
    @books = Book.order(created_at: :desc)
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
  end

  def create
    @customer = current_customer
    @book = Book.new(book_params)
    @book.customer_id = current_customer.id
    if @book.save
      #Visionモデルに画像を渡すと、その画像の解析し、当てはまるカテゴリーを配列として返す。
      tags = Vision.get_image_data(@book.image)
      #該当したタグの配列をeach文で小分けにしてcreateする。
      #1対多の便利な機能、「親.子供create」と記述すれば、親_idが勝手に保存される。   
      tags.each do |tag|
      @book.tags.create(name: tag)
      end
      flash[:success] = "＜投稿に成功しました。＞"
      redirect_to public_book_path(@book)
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
      flash[:edit] = "＜投稿を更新しました。＞"
      redirect_to public_books_path(@book)
    else
       flash[:notice] = "＜更新されていません。＞"
       render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:destroy] = "＜投稿を削除しました。＞"
    redirect_to public_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :place, :explanation, :image)
  end
  
  def ensure_correct_customer
    @book = Book.find(params[:id])
    unless @book.customer == current_customer
      redirect_to public_books_path
    end
  end
  
end

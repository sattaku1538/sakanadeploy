class Public::CustomersController < ApplicationController

    def index
     # @customer = current_customer.id
     @customers = Customer.includes(:books).sort {|a,b| b.favorited_books.size <=> a.favorited_books.size}
    end

    def show
   	 @customer = Customer.find(params[:id])
     @books = @customer.books
     # 変数を定義し、0を代入。いいねｎ合計を表示。
     @favorites_count = 0
     # countメソッドを使い、１つの投稿に結びつくイイねを予め定義しておいた@likes_countに足していく。
      @books.each do |post|
      @favorites_count += post.favorites.count
      end
	   end

   	def edit
   	#  @customer = Customer.find(params[:id])
   	 @customer = current_customer
   	end

   	def update
   	 @customer = current_customer
     if @customer.update(customer_params)
     	redirect_to public_customers_path
     	# フラッシュメッセージいれる？notice: "You have updated your account successfully."
      else
        render "edit"
      end
    end

   	def unsubscribe
   	 @customer = current_customer
    end

    def withdraw
     @customer = current_customer
     @customer.destroy()
     reset_session
     flash[admin] = "退会処理を実行いたしました"
     redirect_to root_path
    end

    private

    def customer_params
     params.require(:customer).permit(:email, :introduction, :name, :profile_image)
    end
end

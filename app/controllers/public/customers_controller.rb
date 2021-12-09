class Public::CustomersController < ApplicationController

    def index
     @customers = Customer.all
    end
    
    def show
   	 @customer = current_customer
    #  @customer = Customer.find(params[:id])
     @books = @customer.books
	end

   	def edit
   	#  @customer = Customer.find(params[:id])
   	 @customer = current_customer
   	end
 
   	def update
   	 @customer = current_customer
   	#  @customer = Customer.find(params[:id])
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
     @customer.update(is_deleted: true)
     reset_session
     # flash[:] = "退会処理を実行いたしました"
     redirect_to public_root_path
    end
    
    private
    
    def customer_params
     params.require(:customer).permit(:email, :introduction, :name, :profile_image)
    end
end

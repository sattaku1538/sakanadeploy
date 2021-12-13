class Admin::CustomersController < ApplicationController
    def index
     @customers = Customer.all
    end
    
    def show
   	 @customer = Customer.find(params[:id])
	   end
 
    def withdraw
     @customer = Customer.find(params[:id])
     @customer.update(is_deleted: true)
     reset_session
     flash[admin] = "退会処理を実行いたしました"
     redirect_to admin_root_path
    end
    
    private
    
    def customer_params
     params.require(:customer).permit(:is_deleted, :email, :introduction, :name, :profile_image)
    end
end

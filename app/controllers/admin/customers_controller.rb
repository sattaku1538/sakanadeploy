class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!,except: [:new_admin_session_path]

    def index
     @customers = Customer.all
     @customers = Kaminari.paginate_array(@customers).page(params[:page]).per(10)
    end

    def show
   	 @customer = Customer.find(params[:id])
	   end

    def withdraw
     @customer = Customer.find(params[:id])
     @customer.destroy()
     flash[:admin] = "＜不正なユーザーを退会させました。＞"
     redirect_to admin_customers_path
    end

    private

    def customer_params
     params.require(:customer).permit(:is_deleted, :email, :introduction, :name, :profile_image)
    end
end

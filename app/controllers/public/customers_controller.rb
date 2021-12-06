class Public::CustomersController < ApplicationController
   before_action :set_customer

    def set_customer
    @customer = current_customer
    end

    def show
  	@books = @customer.books
	end

  	def edit
  	end

  	def update
     if @customer.update(customer_params)
    	redirect_to public_customers_path
    	# フラッシュメッセージいれる？notice: "You have updated your account successfully."
     else
       render "edit"
     end
    end

	  def unsubscribe
    end

      def withdraw
    	@customer.update(is_deleted: true)
    	reset_session
    	redirect_to public_root_path
       end

	  private

	  def customer_params
		params.require(:customer).permit(:email, :introduction, :name, :profile_image, :is_deleted)
    end
end

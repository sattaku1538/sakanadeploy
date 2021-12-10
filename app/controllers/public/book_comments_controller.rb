class Public::BookCommentsController < ApplicationController
    before_action :authenticate_customer!
    
    def create
        @book = Book.find(params[:book_id])
        @book_comment = BookComment.new(book_comment_params)
        @book_comment.book_id = @book.id
        @book_comment.customer_id = current_customer.id
        unless @book_comment.save
        end
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        book_comment = @book.book_comments.find(params[:id])
        book_comment.destroy
    end
    
    private
    
    def book_comment_params
        params.require(:book_comment).permit(:comment)
    end
	
end

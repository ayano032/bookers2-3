class BooksController < ApplicationController
  before_action :authenticate_user!
	def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.page(params[:page]).reverse_order
    @user =current_user
     if @book.save
      flash[:notice]="successfully"
    redirect_to books_path
   else
	render :index
   end
  end

  def index
    @book = Book.new
  	 @books = Book.page(params[:page]).reverse_order
     @user =current_user
     @book.user_id = current_user.id
  end

  def show
    @newbook = Book.new
  	 @book = Book.find(params[:id])
     @user = @book.user
  end

  def destroy
  @book = Book.find(params[:id])
  @book.destroy
  flash[:notice]="successfully"
  redirect_to books_path
end

 def edit
   @book = Book.find(params[:id])
   if @book.user ==current_user
   else
    redirect_to books_path
  end
end



def update
      @book = Book.find(params[:id])
      @books = Book.page(params[:page]).reverse_order
      @user =current_user
    if @book.update(book_params)
       flash[:notice]="successfully"
    redirect_to book_path(@book.id)
   else
flash[:notice]="error"
render :edit
   end
  end

 private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end



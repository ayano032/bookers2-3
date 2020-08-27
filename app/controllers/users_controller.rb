class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

   def edit
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
      if @user ==current_user
   else
    redirect_to(user_url(current_user)) unless @user == current_user
  end

  end

  def update
     @book = Book.new
  	  @user = User.find(params[:id])
      @users = User.page(params[:page]).reverse_order
    if @user.update(user_params)
       flash[:notice]="successfully"
    redirect_to user_path(@user.id)
   else
    flash[:notice]="error"
  render :index
   end
  end

   def new
    @user = User.new
  end

  def index
    @user = User.new
    @book = Book.new
     @books = Book.page(params[:page]).reverse_order
      @users = User.page(params[:page]).reverse_order
     @user =current_user
 end

 private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

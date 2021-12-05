class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @tthisweek_book = @books.created_thisweek
    @lastweek_book = @books.created_lastweek
    @ratio_today = ratio(@today_book.count, @yesterday_book.count)
    @ratio_week = ratio(@tthisweek_book.count, @lastweek_book.count)
    @book = Book.new
  end

  # 前日・前週比を求める計算式
  def ratio(to, from)
    if from == 0
      return 0
    else
      ret = (to / from.to_f)*100
      return ret
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def search
    @user = User.find(params[:user_id])
    create_at = params[:date]
    if create_at == ""
      @count_book = 0
    else
      @count_book = @user.books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

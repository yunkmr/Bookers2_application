class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new

    # 閲覧数をカウント
    impressionist(@book, nil, unique: [:session_hash.to_s])
  end

  def index
    # @books = Book.all
    @book = Book.new
    # @books = Book.left_joins(:week_favorites).group(:id).order('count(book_id) desc')
    @books = Book.all.order(params[:sort])
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category)
    # params.require(:book).permit(:title, :body, :created_at)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end

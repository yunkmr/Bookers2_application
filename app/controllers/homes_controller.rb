class HomesController < ApplicationController
  def top
  end

  def about
  end

  def search
    @books = Book.where(category: params["category"])
  end
end

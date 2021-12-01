class SearchesController < ApplicationController

  def search
    # 検索対象
    @model = params["model"]
    # 検索キーワード
    @keyword = params["keyword"]
    # 部分一致or完全一致
    @method = params["method"]

    @records = search_for(@model, @keyword, @method)
  end

  private

  def search_for(model, keyword, method)
    if model == "user"
      if method == "perfect"
        User.where(name: keyword)
      elsif method == "forward"
        User.where("name LIKE ?", keyword+'%' )
      elsif method == "back"
        User.where("name LIKE ?", '%'+keyword )
      else
        User.where("name LIKE ?", '%'+keyword+'%' )
      end
    elsif model == "book"
      if method == "perfect"
        Book.where(title: keyword)
      elsif method == "forward"
        Book.where("title LIKE ?", keyword+'%' )
      elsif method == "back"
        Book.where("title LIKE ?", '%'+keyword )
      else
        Book.where("title LIKE ?", '%'+keyword+'%' )
      end
    end
  end

end

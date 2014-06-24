class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def seo_object
    return @article if @article
    nil
  end
end

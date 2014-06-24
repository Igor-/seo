class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def seo_object
    return @product if @product
    nil
  end
end

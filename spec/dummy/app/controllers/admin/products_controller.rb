class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.all
  end


  def new
    @product = Product.new
    render 'edit'
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    redirect_or_edit(@product, @product.save)
  end

  def update
    @product = Product.find(params[:id])
    redirect_or_edit(@product, @product.update(product_params))
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: "#{Product.model_name.human} удален."
  end

  private

  def product_params
    params.require(:product).permit!
  end
end

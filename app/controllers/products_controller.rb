class ProductsController < ApplicationController

  def index
    # TODO: Order by, list of all products with the same category
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'El producto se guardó exitosamente.'
    else
      flash[:product_errors] = @product.errors.full_messages
      redirect_back fallback_location: 'products/new'
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path, notice: 'El producto se actualizó exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.categories.clear
    product.destroy

    redirect_to products_path, notice: 'El producto fue eliminado exitosamente.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, category_ids: [])
  end
end

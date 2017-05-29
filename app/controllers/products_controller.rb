class ProductsController < ApplicationController
  def index
    if params[:category].blank?
      @products = case params[:order]
      when 'by_product_price'
          Product.all.order("price DESC")
      when 'by_product_quantity'
        Product.all.order("quantity DESC")
      else
        Product.all.recent
      end

    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(category_id:  @category_id)
    end
  end

  def show
    @product = Product.find(params[:id])
    @photos = @product.photos.all
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] ="你已成功将#{@product.title}加入购物车"
    else
      flash[:warning] ="你的购物车已有此物品"
    end
    redirect_to :back
  end
end

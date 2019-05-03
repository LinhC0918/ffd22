class CartsController < ApplicationController
  require "json"
  before_action :logged_in_user, :load_cart_products,
    except: %i(index new edit)
  before_action :load_item, only: :create
  before_action :check_item_update , only: :update

  def create
    @cart_products.merge!(@item)
    cookies.permanent[current_user.id] = JSON.generate(@cart_products)
    respond_to do |format|
      format.html{redirect_to products_path}
      format.js
    end
  end

  def show; end

  def update
    @cart_products[params[:carts][:product_id]] = params[:carts][:quantity]
    cookies.permanent[current_user.id] = JSON.generate(@cart_products)
    respond_to do |format|
      format.html{redirect_to carts_path}
      format.js
    end
  end

  def destroy
    @cart_products.delete params[:product_id]
    cookies.permanent[current_user.id] = JSON.generate(@cart_products)
    respond_to do |format|
      format.html{redirect_to carts_path}
      format.js
    end
  end

  private

  def load_cart_products
    @cart_products = cart_products
  end

  def load_item
    product_id = params[:cart][:product_id]
    quantity = params[:cart][:quantity]
    if check_item_available product_id, quantity
      if @cart_products[product_id].present?
        quantity = @cart_products[product_id].to_i + quantity.to_i
      end
      @item = {product_id => quantity}
    else
      flash[:danger] = t "controllers.carts.have_error"
      redirect_to products_path
    end
  end

  def check_item_update
    return if check_item_available [params[:carts][:product_id]],
      params[:carts][:quantity]
    flash[:danger] = t "controllers.carts.have_error"
    redirect_to carts_path
  end

  def check_item_available product_id, quantity
    product = Product.find_by(id: product_id)
    return false if product.blank? || quantity < Settings.carts.minimum_quantity.to_s ||
      product.quantity < quantity.to_i
    return true
  end
end

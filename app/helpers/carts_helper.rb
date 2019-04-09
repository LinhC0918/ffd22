module CartsHelper
  def find_product id
    Product.find_by id: id
  end

  def cart_products
    return {} if current_user.nil? || cookies[current_user.id].blank?
    JSON.parse(cookies[current_user.id])
        .select{|x| Product.find_by(id: x).present?}
  end

  def render_cart_quantity
    cart_products.blank? ? Settings.carts.no_product : cart_products.size
  end

  def calculate_total_price
    cart_products.sum do |id, quantity|
      product = find_product id
      product.present? ? product.price.to_i * quantity.to_i : 0
    end
  end
end

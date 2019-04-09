module ProductsHelper
  def categories_ordered
    Category.order(:name).map{|c| [c.name, c.id]}
  end

  def truncate_info info
    info.truncate(Settings.product_information.truncate, separator: " ")
  end

  def load_comments product
    product.comments.order(created_at: :desc)
  end

  def average_rating product
    sum_rating = product.comments.sum(:rating).to_f
    count_rating = product.comments.count(:rating)
    @average_rating = (sum_rating / count_rating).ceil
  end
end

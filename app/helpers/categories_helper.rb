module CategoriesHelper
  def load_children_category category
    category.children.order(:name)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def collect_categories
    Category.all.map{|c| [c.name, c.id]}
  end
end

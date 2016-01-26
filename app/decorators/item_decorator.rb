class ItemDecorator
  def initialize(items)
    @items = items
  end

  def order_pattern(sort_by, query)
    if query.present?
      @items.search_items(query)
    elsif sort_by == 'category'
      @items.order(:category)
    elsif sort_by == 'brand'
      @items.order(:brand)
    elsif sort_by == 'name'
      @items.order(:name)
    else
      @items
    end
  end

  def filter_items(cat)
    if available_categories.include?(cat)
      Item.filtered_categories(cat)
    else
      @items = []
    end
  end

  private

  def available_categories
    categories = []
    @items.each do |item|
      categories << item.category
    end

    categories
  end
end

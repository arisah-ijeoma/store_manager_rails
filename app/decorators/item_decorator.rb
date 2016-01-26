class ItemDecorator
  def initialize(items)
    @items = items
  end

  def order_pattern(sort_by)
    if sort_by == 'category'
      @items.order(:category)
    elsif sort_by == 'brand'
      @items.order(:brand)
    elsif sort_by == 'name'
      @items.order(:name)
    else
      @items
    end
  end

  def item_search(query)
    @items.search_items(query)
  end

  def filter_items(cat)
    if available_categories.include?(cat)
      @items.filtered_categories(cat)
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
